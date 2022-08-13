---
layout: post
title:  "WordPress'de WP Mail SMTP eklentisini yüklemeden SMTP ile nasıl ileti gönderirim?"
tags: [ wordpress ]
image: assets/images/wp-smtp.webp
description: WordPress ile bir site kurduğunuzda iletişim formu veya bülten araçlarının çalışması için mutlaka bir ileti gönderim yöntemi belirlemelisiniz. İşte bu gönderide WordPress için SMTP ayarlarını eklentisiz nasıl yapacağınızı anlatacağım.
---
WordPress sitenizi kurduktan sonra elektronik posta iletilerinin gönderilebilmesi için mutlaka bir gönderim yöntemi belirlemeniz gerekiyor. Genellikle bu SMTP olur ve oldukça yaygın bir yöntemdir. Eğer kodlarla pek aranız yoksa WP Mail SMTP eklentisi sizin için resmen biçilmiş bir kaftandır. [Ücretli](https://wpmailsmtp.com/) ve [ücretsiz](https://tr.wordpress.org/plugins/wp-mail-smtp/) sürümleri bulunsa da WordPress tabanlı sitenize ne kadar az uzantı kurarsanız o kadar etkili performans göstereceğini unutmamak gerekiyor.

Bu rehberdeki iki adımı gerçekleştirerek WP Mail SMTP eklentisi veya benzer eklentiler yerine sadece birkaç satır kod düzenlemesi ile SMTP gönderim ayarlarınızı kendiniz yapabilirsiniz. Gönderiyi buraya kadar okuduğunuza göre hazır olduğunuzu varsayarak adımlara geçiyorum.

## WP Mail SMTP eklentisini kurmadan WordPress SMTP kurulumu nasıl yapılır?
İlk olarak düzenlememiz gereken belgelerin neler olduğunu size açıklayayım;
1. **wp-config.php:** Bu dosya, WordPress kurulumunuzun ana dizininde bulunur. Değiştirmek için FTP veya SSH erişimine ihtiyacınız olacak.
2. **function.php:** Bu dosyaya WordPress yönetici kontrol panelinizden Görünüm > Tema Dosya Düzenleyicisi altında yer alır.

Şimdi hangi belgelere erişmeniz gerektiğini açıkladığıma göre FTP veya SSH üzerinden **wp-config.php**'yi düzenlemeye başlayalım;

### wp-config.php için E-posta ayarlarını tanımlama
1. **wp-config.php belgesini açın.**
2. Şu satırı bulun:
```/* Thats all, stop editing! Happy blogging. */```
3. Üstüne ekleyin:
`// SMTP e-posta ayarları
define( 'SMTP_USER', 'kullaniciadi@alanadi.com' ); // SMTP için kullanılacak elektronik posta adresi
define( 'SMTP_PASS', 'sifreniz' ); // Üst satırda belirlediğiniz elektronik posta adresinin şifresi
define( 'SMTP_HOST', 'smtp.servissaglayici.com' ); // SMTP servis sağlayıcınız
define( 'SMTP_FROM', 'kullaniciadi@alanadi.com' ); // SMTP aracılığı ile gönderilecek iletilerin gönderen bilgisi
define( 'SMTP_NAME', 'Gönderen Adı' ); // İletilerde görünecek isim veya kurum adı
define( 'SMTP_PORT', '587' ); // Port bilgisi (genellikle 587)
define( 'SMTP_SECURE', 'tls' ); // Güvenlik (genellikle tls)
define( 'SMTP_AUTH', true );
`
4. Belgeyi kaydedin ve pencereyi kapatın.

Çok güzel. SMTP servis sağlayıcı bilgilerimizi girip belgeyi kayıt ettikten sonra artık ilk adımı tamamlamış oluyoruz. Eğer yukarıdaki alanlarda hangi bilgileri dolduracağınızı bilmiyorsanız servis sağlayıcınız ile iletişime geçerek bilgileri alabilirsiniz.

![Google Ads'de geniş eşlemeli anahtar kelimeler kullanmayın](/assets/images/wordpress-smtp-mail.webp)

### functions.php içindeki phpmailer_init işlevini geçersiz kılalım
Temanızın functions.php belgesini doğrudan düzenleyebilirsiniz ancak bu her tema güncellemesi ile beraber burada bahsedilen değişikliği yeniden yapmanız anlamına gelir. Eğer WordPress için Child tema kullanmıyorsanız bu sizin için tekrar eden bir süreç olacaktır. Ancak Child tema kurulumunuzu en başından yaptıysanız arkanıza yaslanın ve Child temanızın functions.php belgesini düzenlemenin keyfini çıkartın.

1. ```wp-admin```'e giderek sitenizin yönetim panelini açın ve giriş yapın.
2. Sol menüde yer alan Görünüm > Tema Dosya Düzenleyicisi sayfasını açın.
3. Gelen pencereden Child temanızın seçili olduğundan emin oldun. Ardından sağ kısımda bulunan **functions.php** belgesini açın.
4. Aşağıdaki kodu ekleyin:
`// SMTP ile ileti gönder
add_action( 'phpmailer_init', 'my_phpmailer_orn' );
function my_phpmailer_orn( $phpmailer ) {
    $phpmailer->isSMTP();     
    $phpmailer->Host = SMTP_HOST;
    $phpmailer->SMTPAuth = SMTP_AUTH;
    $phpmailer->Port = SMTP_PORT;
    $phpmailer->Username = SMTP_USER;
    $phpmailer->Password = SMTP_PASS;
    $phpmailer->SMTPSecure = SMTP_SECURE;
    $phpmailer->From = SMTP_FROM;
    $phpmailer->FromName = SMTP_NAME;
}`
5. Belgeyi kaydedin ve kapatın.

Burada yaptığımız şey temelde ```phpmailer_init``` işlevini geçersiz kılarak ```my_phpmailer_orn``` adlı bir işlev oluşturmaktır. wp-config.php dosyasında tanımladığımız PHP değişkenlerini burada kullandık. Bu şekilde web sitemizde kullandığımız başka bir eklenti de (Örn. Contact Form 7 veya Elementor Forms) burada tanımladığımız SMTP ayarlarını kullanabilecek.

Eğer SMTP bilgilerinizi doğru girdiyseniz ve tüm kodları doğru bir şekilde yerleştirdiyseniz herhangi bir eklentiye ihtiyaç duymadan WordPress sitenizle SMTP kullanarak elektronik posta gönderimi gerçekleştirebileceksiniz.