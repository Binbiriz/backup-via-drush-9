# kullanım
# Drush 9'da 'drush ard' komutunun kaldırılması nedeni ile
# içinde drush sql-dump komutunun da bulunduğu backup kodu
# scriptin parametrelerinde her ikisinin de çift tırnak
# içinde girilmiş olması gerekir.
# ikinci parametrenin sonundaki / işareti olmalıdır.
# sonuç olarak kullanıcı dizininizin içinde
# içinde veritabanı yedeğinin ve tüm dosyaların olduğu 
# uzantısı tar.gz olan tek bir arşiv dosyası oluşacak
# tıpkı drush 8'deki 'drush ard' komutunda elde edildiği gibi
# bash backupdrupal.sh "drupal_site_adi" "/drupal/kurulumu/kok/dizini/"

# $1 değişkeni betiğe gönderdiğiniz "drupal_site_adi"
# $2 değişkeni betiğe gönderdiğiniz "/drupal/kurulumu/kok/dizini/"
# değerini alır.

# Drush Launcher Version: 0.6.0
# Drush Commandline Tool 9.4.0
# ile test edilmiştir.

# backup zamanı oluşturulur
timestamp=$(date +%Y%m%d_%H%M%S)

# backup dizini tanımlanır.
backupdirbase=$HOME/backups
backupdir=$HOME/backups/$timestamp

# backup dizini oluşturulu
mkdir -p $backupdir

# tüm dosyalar timestamp ve yetkiler ile kopyalanır.
cp -rp $2 $backupdir

# tüm cache'ler temizlenir
# bunu dilerseniz önündeki # işaretini kaldırarak kullanabilirsiniz
# cache temizlemek veritabanını küçültecektir
# ancak her yedek alındığında cache temizlemek
# cache'leme stratejinize ters düşüyorsa bu şekilde
# bırakınız.
# drush cr --root=$2

# sql yedeği alınır.
drush sql-dump --root=$2 | gzip > $backupdir/$1_$timestamp.sql.gz

# dosyalar ve sql yedeği tek bir arşiv dosyası haline getirilir.
tar -zcvf $backupdirbase/$1_$timestamp.tar.gz -C /$backupdir .

# gereksiz dizin silinir.
rm -rf $backupdir/
