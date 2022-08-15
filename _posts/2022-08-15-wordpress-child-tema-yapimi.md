---
layout: post
title:  "WordPress'de child tema nasıl yapılır?"
tags: [ wordpress ]
image: assets/images/wp-child.webp
description: Eğer WordPress tabanlı bir internet sitesi kullanıyorsanız temanızı güncellediğinizde yaptığınız özelleştirmelerin silinmesini istemezsiniz. İşte bu nedenle bir Child temaya ihtiyacınız olacak.
---
Bu eğitimde bir diğer ifade ile kullandığınız temadan bağımsız olarak WordPress tabanlı internet sitenizde nasıl çocuk veya alt tema oluşturacağınızı göreceksiniz. Bu işlem eğer WordPress kullanmaya yeni başlıyorsanız tahmin ettiğinizden çok basit birkaç adımdan oluşuyor. Dolayısıyla süreci kesinlikle gözünüzde büyütmeyin.

Rehberdeki adımları gerçekleştirmek için FTP veya SSH aracılığı ile sitenizin sunucu dosyalarınıza erişmeniz gerekecek, dolayısıyla adımlara geçmeden önce sunucunuza erişiminiz olduğundan emin olun.

## WordPress Alt (Çocuk) Tema Oluşturma Rehberi
WordPress'deki bir alt temanın temel iki parçası bulunmaktadır;
- **style.css**
- **functions.php**

Öncelikle child (alt) temanız için bir dizin oluşturmakla başlayalım. Rehberin herkes tarafından kolayca anlaşılabilmesi için WordPress 6 ile beraber gelen **twentytwentytwo** temasını baz alacağım. wp-content/themes dizini içerisinde Twenty Twenty-Two teması için twentytwentytwo klasörü yer almakta. Şimdi aynı dizin olan wp-content/themes içerisinde ttt-child adlı bir klasör oluşturacağım. Eğer SSH sunucunuzda oturum açtıysanız aşağıdaki komut size yardımcı olacaktır.

```
cd /var/www/html/wp-content/
mkdir ttt-child
cd ttt-child/
```

Şimdi ise aşağıdaki kodları kullanarak bu yeni klasörün içerisinde style.css belgesi oluşturarak içine aşağıdaki kodu ekleyin:
```
/*
Theme Name: Twenty Twenty-Two Child
Text Domain: ttt-child
Version: 1.0
Template: twentytwentytwo
Author: Tolga Altaş
Author URI: https://tolgaaltas.com
License: GNU General Public License v2 or later
License URI: http://www.gnu.org/licenses/gpl-2.0.html
*/
```

![WordPress Child Alt Çocuk Tema Yapımı](/assets/images/wp-child-theme.webp)

Şimdi ise functions.php adlı bir dosya oluşturalım ve içine aşağıdaki kodları ekleyelim:
```
<?php

// incherit parent theme styles
add_action( 'wp_enqueue_scripts', 'enqueue_parent_styles' );
function enqueue_parent_styles() {
   wp_enqueue_style( 'parent-style', get_template_directory_uri().'/style.css' );
}
```

Yukarıdaki kod, ana temanın stillerini üstlenir.

İşte bu kadar, artık WordPress için bir alt (çocuk) temaya sahipsiniz. Artık Görünüm > Temalar altından oluşturduğunuz Child temayı seçebilirsiniz. Dilerseniz Temalar içerisinde bir görsele sahip olabilmesi için screenshot.png adlı bir belge oluşturabilirsiniz ama bu tamamen opsiyoneldir.