
#!/bin/bash
# Create new virtual host from template template file.
# Used with Zend Server on Ubuntu to create a sub
# directory in /home for each named virtual hosted site

# Create Virtual Host

base="/home/"
wrapper="/www"
pub="/public_html"
email="webmaster@localhost"

# remove function
autohost-remove() {
echo "base is $base"
if [ -n $name ]; then
    if [ -d "$base$name" ]; then
        sudo rm -ri "$base$name"
        sudo rm -ri /etc/apache2/sites-available/$name
    else
         echo "$base$name did not exist"
    fi
else
    echo "You must provide a name to remove a virutal host".
fi

exit 0
}

while [ $1 ]; do
    case "$1" in
        '-n'|'--name') name="$2";;
        '-h'|'--help') autohost-usage;;
        '-rm'|'--remove') name="$2"
              autohost-remove;;
        '-u'|'--url') url=$2;;
    esac
    shift
done

sudo -v

webroot="$base$name$wrapper$pub"

if [ ! -d "$base$name" ]; then
    if [ ! -L "$base$name" ]; then

        # Neither a Directory or SymLnk exists.
        # We can Begin Building the Virtual Host.
        sudo mkdir "$base$name"
        sudo mkdir "$base$name$wrapper"
        sudo mkdir "$base$name$wrapper$pub"
        sudo chown -R digium:digium "$base$name"
    else
        #Its a link handle
        echo "A Symlink exists. please remove it or check your desiredname"
        exit 0
    fi
else
    #The Directory Already Exists.
    echo "Directory already exists in /home for $name"
    exit 0
fi

# replace variables in vhost template /etc/apache2/sites-available/template
sudo cp /etc/apache2/sites-available/template /etc/apache2/sites-available/$name
sudo sed -i 's/autohost.email/'$email'/g' /etc/apache2/sites-available/$name
sudo sed -i 's/autohost.alias/'$url'/g' /etc/apache2/sites-available/$name
sudo sed -i 's/autohost.name/'$name'/g' /etc/apache2/sites-available/$name

# Since $webroot contains a file path with '/' use ; as a seperator for SED
sudo sed -i 's;autohost.docroot;'$webroot';g' /etc/apache2/sites-available/$name

sudo a2ensite $name

sudo service apache2 reload

echo "Named Virtual host for $name created at $webroot with URL: $url"
exit 0


