-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 04, 2024 at 03:20 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pharmastore`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `profile_photo_path` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `product` varchar(255) DEFAULT NULL,
  `slider` varchar(255) DEFAULT NULL,
  `coupons` varchar(255) DEFAULT NULL,
  `shipping` varchar(255) DEFAULT NULL,
  `blog` varchar(255) DEFAULT NULL,
  `setting` varchar(255) DEFAULT NULL,
  `review` varchar(255) DEFAULT NULL,
  `orders` varchar(255) DEFAULT NULL,
  `stock` varchar(255) DEFAULT NULL,
  `reports` varchar(255) DEFAULT NULL,
  `alluser` varchar(255) DEFAULT NULL,
  `adminuserrole` varchar(255) DEFAULT NULL,
  `type` int(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `profile_photo`, `profile_photo_path`, `email_verified_at`, `password`, `phone`, `brand`, `category`, `product`, `slider`, `coupons`, `shipping`, `blog`, `setting`, `review`, `orders`, `stock`, `reports`, `alluser`, `adminuserrole`, `type`, `remember_token`, `created_at`, `updated_at`) VALUES
(4, 'Abdelrahman Soliman', 'admin@gmail.com', NULL, 'upload/admin_images/1782803186372274.jpeg', NULL, '$2y$10$lFXDJjHhPFnG3gqX8GxFpu9XyB1MRjt1UB.16G3UhKk/WBB1N.qBW', '01025786389', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', 2, NULL, '2023-11-17 07:33:30', '2023-11-17 07:33:30'),
(5, 'Admin', 'admin@admin.com', NULL, NULL, NULL, '$2y$10$t9VJerIx.9C1G7onHN5XU.lhquVki9rHNaL0jwI2xELmslntfgD0C', NULL, '1', '1', '1', '1', '1', NULL, NULL, '1', NULL, NULL, NULL, NULL, '1', NULL, 2, NULL, '2023-12-27 13:12:00', '2023-12-27 13:12:00');

-- --------------------------------------------------------

--
-- Table structure for table `blog_posts`
--

CREATE TABLE `blog_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `post_title_en` varchar(255) NOT NULL,
  `post_title_ar` varchar(255) NOT NULL,
  `post_slug_en` varchar(255) NOT NULL,
  `post_slug_ar` varchar(255) NOT NULL,
  `post_image` varchar(255) NOT NULL,
  `post_details_en` text NOT NULL,
  `post_details_ar` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blog_posts`
--

INSERT INTO `blog_posts` (`id`, `category_id`, `post_title_en`, `post_title_ar`, `post_slug_en`, `post_slug_ar`, `post_image`, `post_details_en`, `post_details_ar`, `created_at`, `updated_at`) VALUES
(3, 2, 'News From Pharma', 'الجديد من فارما', 'news-from-pharma', 'الجديد-من-فارما', 'upload/post/1783006953713350.png', '<p>details</p>', '<p>تفاصيل الموضوع</p>', '2023-11-19 13:32:18', NULL),
(4, 2, 'latest version', 'احدث منتاجاتنا', 'latest-version', 'احدث-منتاجاتنا', 'upload/post/1783007009430035.png', '<p>details</p>', '<p>تفاصيل المنتج</p>', '2023-11-19 13:33:11', NULL),
(5, 1, 'latest version', 'احدث منتاجاتنا', 'latest-version', 'احدث-منتاجاتنا', 'upload/post/1783007080152008.png', '<p>new</p>', '<p>جديد</p>', '2023-11-19 13:34:18', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `blog_post_categories`
--

CREATE TABLE `blog_post_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `blog_category_name_en` varchar(255) NOT NULL,
  `blog_category_name_ar` varchar(255) NOT NULL,
  `blog_category_slug_en` varchar(255) NOT NULL,
  `blog_category_slug_ar` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blog_post_categories`
--

INSERT INTO `blog_post_categories` (`id`, `blog_category_name_en`, `blog_category_name_ar`, `blog_category_slug_en`, `blog_category_slug_ar`, `created_at`, `updated_at`) VALUES
(1, 'Rexona', 'ريكسونا', 'rexona', 'ريكسونا', '2023-11-09 10:43:38', NULL),
(2, 'Sunsilk', 'صانصيلك', 'sunsilk', 'صانصيلك', '2023-11-09 10:46:50', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `brand_name_en` varchar(255) NOT NULL,
  `brand_name_ar` varchar(255) NOT NULL,
  `brand_slug_en` varchar(255) NOT NULL,
  `brand_slug_ar` varchar(255) NOT NULL,
  `brand_image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `brand_name_en`, `brand_name_ar`, `brand_slug_en`, `brand_slug_ar`, `brand_image`, `created_at`, `updated_at`) VALUES
(3, 'Oxi', 'اوكسي', 'oxi', 'اوكسي', 'upload/brand/1782077166180061.png', NULL, NULL),
(4, 'Sunsilk', 'صانصيلك', 'sunsilk', 'صانصيلك', 'upload/brand/1782077198313644.jpeg', NULL, NULL),
(5, 'molfix', 'مولفيكس', 'molfix', 'مولفيكس', 'upload/brand/1782077219795114.png', NULL, NULL),
(6, 'pampers', 'يامبرز', 'pampers', 'يامبرز', 'upload/brand/1782077237363081.png', NULL, NULL),
(8, 'DOVE', 'دوف', 'dove', 'دوف', 'upload/brand/1782077299613148.png', NULL, NULL),
(10, 'FINE', 'فاين', 'fine', 'فاين', 'upload/brand/1782077388481826.jpeg', NULL, NULL),
(11, 'none', 'لا يوجد', 'none', 'لا-يوجد', 'upload/brand/1783003681297806.jpg', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_name_en` varchar(255) NOT NULL,
  `category_name_ar` varchar(255) NOT NULL,
  `category_slug_en` varchar(255) NOT NULL,
  `category_slug_ar` varchar(255) NOT NULL,
  `category_icon` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category_name_en`, `category_name_ar`, `category_slug_en`, `category_slug_ar`, `category_icon`, `created_at`, `updated_at`) VALUES
(1, 'Personal Care', 'العنايه الشخصية', 'personal-care', 'العنايه-الشخصية', 'fa fa-bath', NULL, '2023-11-09 07:27:17'),
(2, 'Babies', 'الاطفال', 'babies', 'الاطفال', 'fa fa-envelope-open-o', NULL, '2023-11-09 07:06:53'),
(4, 'Medical Equipment', 'ادوات طبية', 'medical-equipment', 'ادوات-طبية', 'fa-free-code-camp', NULL, NULL),
(5, 'Health Care', 'العنايه بالصحة', 'health-care', 'العنايه-بالصحة', 'fa fa-envelope-open-o', NULL, NULL),
(6, 'Medicine', 'ادوية', 'medicine', 'ادوية', 'fa fa-free-code-camp', NULL, NULL),
(7, 'MOM And Baby', 'الاب والام', 'mom-and-baby', 'الاب-والام', 'fa-free-code-camp', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `coupon_name` varchar(255) NOT NULL,
  `coupon_discount` int(11) NOT NULL,
  `coupon_validity` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `coupon_name`, `coupon_discount`, `coupon_validity`, `status`, `created_at`, `updated_at`) VALUES
(1, 'FS15', 15, '2023-11-11', 1, '2023-11-09 07:20:21', NULL),
(2, 'FS20', 20, '2023-11-15', 1, '2023-11-09 07:20:39', NULL),
(3, 'FS10', 10, '2023-11-14', 1, '2023-11-09 07:21:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_04_11_103446_create_admins_table', 1),
(6, '2023_10_15_223745_create_products_table', 1),
(7, '2023_10_17_045240_create_brands_table', 1),
(8, '2023_10_17_223653_create_orders_table', 1),
(9, '2023_10_17_223744_create_order_items_table', 1),
(10, '2023_10_18_103712_create_categories_table', 1),
(11, '2023_10_18_114429_create_sub_categories_table', 1),
(12, '2023_10_18_215615_create_multi_images_table', 1),
(13, '2023_10_20_013647_create_sliders_table', 1),
(14, '2023_10_24_232845_add_phone_to_users', 1),
(15, '2023_10_25_001232_add_profile_photo_path_to_users', 1),
(16, '2023_10_25_031840_add_profile_photo_path_to_admins', 1),
(17, '2023_10_26_133925_add_last_seen_to_users', 1),
(18, '2023_10_26_135827_create_blog_post_categories_table', 1),
(19, '2023_10_26_141843_create_blog_posts_table', 1),
(20, '2023_10_26_162037_create_site_settings_table', 1),
(21, '2023_10_26_232428_create_seos_table', 1),
(22, '2023_10_27_035626_create_reviews_table', 1),
(23, '2023_10_28_082619_create_carts_table', 1),
(24, '2023_10_30_034647_add_profile_photo_to_admins', 1),
(25, '2023_10_30_043052_create_testominals_table', 1),
(26, '2023_10_31_204951_create_coupons_table', 1),
(27, '2023_10_31_210835_create_ship_divisions_table', 1),
(28, '2023_10_31_211806_create_ship_districts_table', 1),
(29, '2023_10_31_212828_create_ship_states_table', 1),
(30, '2023_11_01_052423_create_wishlists_table', 1),
(31, '2023_11_01_062949_create_shippings_table', 1),
(32, '2023_11_01_224126_add_status_to_orders', 1),
(33, '2023_11_16_182426_add_session_id_to_orders', 2);

-- --------------------------------------------------------

--
-- Table structure for table `multi_images`
--

CREATE TABLE `multi_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_photo` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `multi_images`
--

INSERT INTO `multi_images` (`id`, `product_id`, `product_photo`, `created_at`, `updated_at`) VALUES
(1, 1, 'upload/products/multi-image/1781462683291898.jpg', '2023-11-02 12:26:46', NULL),
(2, 2, 'upload/products/multi-image/1781462725861218.jpg', '2023-11-02 12:27:27', NULL),
(3, 3, 'upload/products/multi-image/1782087283553740.png', '2023-11-09 09:54:32', NULL),
(4, 4, 'upload/products/multi-image/1782087666370368.jpeg', '2023-11-09 10:00:37', NULL),
(5, 4, 'upload/products/multi-image/1782087666547906.jpeg', '2023-11-09 10:00:37', NULL),
(16, 10, 'upload/products/multi-image/1783003917353707.jpg', '2023-11-19 12:44:02', NULL),
(17, 12, 'upload/products/multi-image/1783004172409030.jpg', '2023-11-19 12:48:05', NULL),
(18, 13, 'upload/products/multi-image/1783004267669411.jpg', '2023-11-19 12:49:36', NULL),
(19, 14, 'upload/products/multi-image/1783004384448269.jpg', '2023-11-19 12:51:27', NULL),
(20, 15, 'upload/products/multi-image/1783004501957456.jpg', '2023-11-19 12:53:19', NULL),
(21, 16, 'upload/products/multi-image/1783004635757663.jpg', '2023-11-19 12:55:27', NULL),
(22, 17, 'upload/products/multi-image/1783004884966470.jpg', '2023-11-19 12:59:25', NULL),
(23, 18, 'upload/products/multi-image/1783005072684934.jpg', '2023-11-19 13:02:24', NULL),
(24, 19, 'upload/products/multi-image/1783005189488867.jpg', '2023-11-19 13:04:15', NULL),
(25, 20, 'upload/products/multi-image/1783005330107115.jpg', '2023-11-19 13:06:29', NULL),
(26, 21, 'upload/products/multi-image/1783005458149440.png', '2023-11-19 13:08:31', NULL),
(27, 22, 'upload/products/multi-image/1783005543272301.png', '2023-11-19 13:09:53', NULL),
(28, 23, 'upload/products/multi-image/1783007420028087.jpg', '2023-11-19 13:39:42', NULL),
(29, 24, 'upload/products/multi-image/1783007630777122.jpg', '2023-11-19 13:43:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `division_id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `post_code` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `payment_type` varchar(255) NOT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `currency` varchar(255) NOT NULL,
  `amount` double(8,2) NOT NULL,
  `order_number` varchar(255) DEFAULT NULL,
  `invoice_no` varchar(255) NOT NULL,
  `order_date` varchar(255) NOT NULL,
  `order_month` varchar(255) NOT NULL,
  `order_year` varchar(255) NOT NULL,
  `confirmed_date` varchar(255) DEFAULT NULL,
  `processing_date` varchar(255) DEFAULT NULL,
  `picked_date` varchar(255) DEFAULT NULL,
  `shipped_date` varchar(255) DEFAULT NULL,
  `delivered_date` varchar(255) DEFAULT NULL,
  `cancel_date` varchar(255) DEFAULT NULL,
  `return_date` varchar(255) DEFAULT NULL,
  `return_reason` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `session_id` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `division_id`, `district_id`, `name`, `email`, `phone`, `post_code`, `notes`, `payment_type`, `payment_method`, `transaction_id`, `currency`, `amount`, `order_number`, `invoice_no`, `order_date`, `order_month`, `order_year`, `confirmed_date`, `processing_date`, `picked_date`, `shipped_date`, `delivered_date`, `cancel_date`, `return_date`, `return_reason`, `status`, `session_id`, `created_at`, `updated_at`) VALUES
(87, 3, 5, 1, 'Mahmoud Samir', 'samir@user.com', '01128040819', 99, 'null', 'Card Order', 'card', NULL, 'OMR', 18.00, NULL, 'EOS36449140', '21 November 2023', 'November', '2023', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'processing', 'checkout_N8PuuvMqsY6qxXjN0l2tVcdDW2gAqVgZS0s4rav4aOmEXIeJBJ', '2023-11-21 06:01:39', '2023-11-21 06:14:32'),
(89, 3, 5, 2, 'Mahmoud Samir', 'samir@user.com', '01128040819', 9000, 'nuuu', 'Cash Order', 'cash', NULL, 'OMR', 200.00, NULL, 'EOS31198158', '21 November 2023', 'November', '2023', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'processing', NULL, '2023-11-21 06:06:12', '2023-11-21 06:13:38'),
(90, 3, 5, 2, 'Mahmoud Samir', 'samir@user.com', '01128040819', 999, 'null', 'Card Order', 'card', NULL, 'OMR', 18.00, NULL, 'EOS64833488', '21 November 2023', 'November', '2023', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'processing', 'checkout_FGoSKQYxA8mNGD3KpMLPI3dT3tt3KfXUQ8s9T2DzWl3Jt043iQ', '2023-11-21 06:10:29', '2023-11-21 06:13:22'),
(91, 3, 5, 124, 'Mahmoud Samir', 'samir@user.com', '01128040819', 99, 'null', 'Cash Order', 'cash', NULL, 'OMR', 18.00, NULL, 'EOS70170933', '21 November 2023', 'November', '2023', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'processing', NULL, '2023-11-21 07:02:43', '2023-11-21 07:04:08'),
(92, 3, 5, 79, 'Mahmoud Samir', 'samir@user.com', '01128040819', 900, 'null', 'Cash Order', 'cash', NULL, 'OMR', 36.00, NULL, 'EOS88594208', '21 November 2023', 'November', '2023', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'confirm', NULL, '2023-11-21 07:04:35', '2023-11-21 07:05:24'),
(93, 3, 5, 126, 'Mahmoud Samir', 'samir@user.com', '01128040819', 899, 'null', 'Card Order', 'card', NULL, 'OMR', 100.00, NULL, 'EOS25137450', '21 November 2023', 'November', '2023', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'confirm', 'checkout_QVCg3QdPy6DhlI9Hqvq2K1Jfop76j9mFpkMSJuHS4FOGt6KBzA', '2023-11-21 08:48:39', '2023-11-21 08:49:31'),
(94, 5, 5, 15, 'hager12', 'hager@gmail.com', '01128040819', 8888, 'm,mm', 'Cash Order', 'cash', NULL, 'OMR', 18.00, NULL, 'EOS88621434', '25 December 2023', 'December', '2023', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'confirm', NULL, '2023-12-25 14:02:40', '2023-12-25 14:03:32'),
(95, 6, 5, 76, 'hager12', 'hagerr@gmail.com', '01128040819', 888, ', mbnm,', 'Cash Order', 'cash', NULL, 'OMR', 18.00, NULL, 'EOS99809463', '27 December 2023', 'December', '2023', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'confirm', NULL, '2023-12-27 12:43:05', '2023-12-27 12:45:30'),
(96, 6, 5, 76, 'hager12', 'hagerr@gmail.com', '01128040819', 888, ', mbnm,', 'Cash Order', 'cash', NULL, 'OMR', 18.00, NULL, 'EOS27597241', '27 December 2023', 'December', '2023', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'confirm', NULL, '2023-12-27 12:44:09', '2023-12-27 12:45:05');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `qty` varchar(255) NOT NULL,
  `price` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `qty`, `price`, `created_at`, `updated_at`) VALUES
(27, 89, 22, '1', 100.00, '2023-11-21 06:06:15', '2023-11-21 06:06:15'),
(28, 89, 22, '1', 100.00, '2023-11-21 06:06:15', '2023-11-21 06:06:15'),
(29, 92, 24, '1', 18.00, '2023-11-21 07:04:39', '2023-11-21 07:04:39'),
(30, 92, 24, '1', 18.00, '2023-11-21 07:04:39', '2023-11-21 07:04:39'),
(31, 94, 24, '1', 18.00, '2023-12-25 14:02:47', '2023-12-25 14:02:47'),
(32, 96, 24, '1', 18.00, '2023-12-27 12:44:13', '2023-12-27 12:44:13');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `brand_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory_id` int(11) NOT NULL,
  `product_name_en` varchar(255) NOT NULL,
  `product_name_ar` varchar(255) NOT NULL,
  `product_slug_en` varchar(255) NOT NULL,
  `product_slug_ar` varchar(255) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `product_size_ar` varchar(255) DEFAULT NULL,
  `product_size_en` varchar(255) DEFAULT NULL,
  `selling_price` varchar(255) NOT NULL,
  `discount_price` varchar(255) DEFAULT NULL,
  `product_qyt` int(255) NOT NULL,
  `short_desc_en` varchar(255) NOT NULL,
  `short_desc_ar` varchar(255) NOT NULL,
  `product_tag_en` varchar(255) NOT NULL,
  `product_tag_ar` varchar(255) NOT NULL,
  `long_desc_en` varchar(255) NOT NULL,
  `long_desc_ar` varchar(255) NOT NULL,
  `product_thambnail` varchar(255) NOT NULL,
  `hot_deals` int(11) DEFAULT NULL,
  `feature` int(11) DEFAULT NULL,
  `special_offer` int(11) DEFAULT NULL,
  `special_deal` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `brand_id`, `category_id`, `subcategory_id`, `product_name_en`, `product_name_ar`, `product_slug_en`, `product_slug_ar`, `product_code`, `product_size_ar`, `product_size_en`, `selling_price`, `discount_price`, `product_qyt`, `short_desc_en`, `short_desc_ar`, `product_tag_en`, `product_tag_ar`, `long_desc_en`, `long_desc_ar`, `product_thambnail`, `hot_deals`, `feature`, `special_offer`, `special_deal`, `status`, `created_at`, `updated_at`) VALUES
(10, 11, 5, 12, 'Vitamin', 'فيتامين', 'vitamin', 'فيتامين', 'B400v99', 'null', 'null', '5', NULL, 90, 'vitamin c  50 ML', 'فيتامين سي 50 مل', 'vitamin', 'فيتامينات', '<p>not found</p>', '<p>لا يوجد</p>', 'upload/products/thambnail/1783003916961305.jpg', NULL, NULL, NULL, NULL, 1, '2023-11-19 12:44:01', NULL),
(11, 11, 5, 13, 'powerful bottle', 'مشورب طاقه', 'powerful-bottle', 'مشورب-طاقه', 'B400v99kkk', 'null', 'null', '15', NULL, 4, 'powerful bottle  320 ml', 'مشورب طاقه 320 مل', 'power', 'مشروب طاقه', '<p>none</p>', '<p>لا يوجد</p>', 'upload/products/thambnail/1783004128933889.jpg', NULL, NULL, NULL, NULL, 1, '2023-11-19 12:47:23', NULL),
(12, 11, 5, 13, 'powerful bottle', 'مشورب طاقه', 'powerful-bottle', 'مشورب-طاقه', 'B400v99kkk', 'null', 'null', '15', NULL, 4, 'powerful bottle  320 ml', 'مشورب طاقه 320 مل', 'power', 'مشروب طاقه', '<p>none</p>', '<p>لا يوجد</p>', 'upload/products/thambnail/1783004171959836.jpg', NULL, NULL, NULL, NULL, 1, '2023-11-19 12:48:05', NULL),
(13, 11, 5, 13, 'powerful bottle', 'مشورب طاقه', 'powerful-bottle', 'مشورب-طاقه', 'B400v99kkk', 'null', 'null', '15', '7', 30, 'powerful bottle', 'مشروب طاقة', 'null', 'null', '<p>none</p>', '<p>لا يوجد حاليا</p>', 'upload/products/thambnail/1783004267278888.jpg', NULL, NULL, NULL, NULL, 1, '2023-11-19 12:49:36', NULL),
(14, 11, 4, 20, 'كمامة', 'كمامة', 'كمامة', 'كمامة', 'B400v99kkk', 'null', 'null', '15', '7', 30, 'كمامه واقي للفم', 'كمامه واقي للفم', 'null', 'null', '<p>none</p>', '<p>لا يوجد</p>', 'upload/products/thambnail/1783004384192321.jpg', NULL, NULL, NULL, NULL, 1, '2023-11-19 12:51:27', NULL),
(15, 11, 4, 19, 'temperature check', 'قياس الحرارة', 'temperature-check', 'قياس-الحرارة', 'B400v99kkk', 'null', 'null', '100', NULL, 30, 'temperature check', 'مقياس لدرجه حراره الجسم', 'null', 'null', '<p>none</p>', '<p>لا يوجد</p>', 'upload/products/thambnail/1783004501717538.jpg', NULL, NULL, NULL, NULL, 1, '2023-11-19 12:53:19', NULL),
(16, 11, 6, 17, 'panadol extra', 'بنادول اكسترا', 'panadol-extra', 'بنادول-اكسترا', 'B400v99kkk', 'null', 'null', '100', NULL, 30, 'panadol extra', 'بنادول اكسترا', 'null', 'null', '<p>panadol extra</p>', '<p>بنادول اكسترا</p>', 'upload/products/thambnail/1783004635473529.jpg', NULL, 1, NULL, NULL, 1, '2023-11-19 12:55:27', NULL),
(17, 11, 1, 21, 'face cream', 'كريم للوجه', 'face-cream', 'كريم-للوجه', 'B400v99kkk', 'null', 'null', '100', NULL, 30, 'face cream 25 ml', 'كريم مرطب للوجه 25 مل', 'cream', 'كريم', '<p>none</p>', '<p>لا يوجد</p>', 'upload/products/thambnail/1783004884586917.jpg', NULL, 1, NULL, NULL, 1, '2023-11-19 12:59:24', NULL),
(18, 11, 6, 18, 'strepsils', 'ستريبسل', 'strepsils', 'ستريبسل', 'B400v99kkk', 'null', 'null', '100', NULL, 30, 'strepsils', 'ستريبسل لالتهاب الحلق', 'strepsils', 'ستريبسل', '<p>none</p>', '<p>لا يوجد</p>', 'upload/products/thambnail/1783005072411651.jpg', NULL, 1, NULL, NULL, 1, '2023-11-19 13:02:23', NULL),
(19, 11, 6, 17, 'lartex', 'لارتيكس', 'lartex', 'لارتيكس', 'B400v99kkk', 'null', 'null', '100', NULL, 30, 'lartex', 'لارتيكس', 'lartex', 'لارتيكس', '<p>none</p>', '<p>لارتيكس</p>', 'upload/products/thambnail/1783005189135659.jpg', NULL, 1, NULL, NULL, 1, '2023-11-19 13:04:15', NULL),
(20, 11, 1, 21, 'newhilar', 'نيوهيلار', 'newhilar', 'نيوهيلار', 'B400v99kkk', 'null', 'null', '100', NULL, 30, 'newhilar', 'نيوهيلار', 'stomach', 'مسكن للمعدة', '<p>none</p>', '<p>لا يوجد</p>', 'upload/products/thambnail/1783005329894669.jpg', 1, 1, NULL, NULL, 1, '2023-11-19 13:06:29', NULL),
(21, 11, 2, 15, 'newhilar', 'نيوهيلار', 'newhilar', 'نيوهيلار', 'B400v99kkk', 'null', 'null', '100', NULL, 30, 'for babies', 'مسكن للاطفال', 'mosaken', 'مسكن للاطفال', '<p>none</p>', '<p>لا يوجد</p>', 'upload/products/thambnail/1783005457771833.png', 1, NULL, NULL, 1, 1, '2023-11-19 13:08:31', NULL),
(22, 11, 2, 16, 'babies relax', 'نيوهيلار', 'babies-relax', 'نيوهيلار', 'B400v99kkk', 'null', 'null', '100', NULL, 30, 'moasken', 'مسكن للاطفال', 'null', 'null', '<p>none</p>', '<p>لا يوجد</p>', 'upload/products/thambnail/1783005542388201.png', 1, NULL, 1, 1, 1, '2023-11-19 13:09:52', NULL),
(23, 11, 2, 15, 'babies relax', 'نيوهيلار', 'babies-relax', 'نيوهيلار', 'B400v99kkk', 'null', 'null', '18', '16', 30, 'none', 'لايوجد', 'null', 'null', '<p>none</p>', '<p>لايوجد</p>', 'upload/products/thambnail/1783007419704956.jpg', 1, NULL, NULL, NULL, 1, '2023-11-19 13:39:42', NULL),
(24, 11, 2, 15, 'babies food', 'طعام الاطفال', 'babies-food', 'طعام-الاطفال', 'B400v99kkk', 'null', 'null', '18', '16', 30, 'none', 'لايوجد', 'null', 'null', '<p>none</p>', '<p>لا يوجد</p>', 'upload/products/thambnail/1783007630559085.jpg', 1, NULL, NULL, NULL, 1, '2023-11-19 13:43:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `comment` varchar(255) NOT NULL,
  `summary` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seos`
--

CREATE TABLE `seos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_author` varchar(255) DEFAULT NULL,
  `meta_keyword` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `google_analytics` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seos`
--

INSERT INTO `seos` (`id`, `meta_title`, `meta_author`, `meta_keyword`, `meta_description`, `google_analytics`, `created_at`, `updated_at`) VALUES
(1, 'pharma store', 'shopping', 'shop', 'pharama', 'none', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `shippings`
--

CREATE TABLE `shippings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `division_id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `shipping_name` varchar(255) NOT NULL,
  `shipping_email` varchar(255) NOT NULL,
  `shipping_phone` varchar(255) NOT NULL,
  `post_code` int(11) NOT NULL,
  `notes` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ship_districts`
--

CREATE TABLE `ship_districts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `division_id` bigint(20) UNSIGNED NOT NULL,
  `district_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ship_districts`
--

INSERT INTO `ship_districts` (`id`, `division_id`, `district_name`, `created_at`, `updated_at`) VALUES
(1, 5, 'Mina Salman', '2023-11-21 08:16:34', NULL),
(2, 5, 'Qofool', '2023-11-21 08:17:21', NULL),
(3, 5, 'Qudaibiya', '2023-11-21 08:17:35', NULL),
(4, 5, 'Ras Ruman', '2023-11-21 08:17:50', NULL),
(5, 5, 'Salmaniya', '2023-11-21 08:17:59', NULL),
(6, 5, 'none', '2023-11-21 08:18:08', NULL),
(7, 5, 'East Riffa', '2023-11-21 08:18:17', NULL),
(8, 5, 'West Riffa', '2023-11-21 08:18:44', NULL),
(9, 5, 'North Riffa', '2023-11-21 08:18:51', NULL),
(10, 5, 'Riffa', '2023-11-21 08:18:59', NULL),
(11, 5, 'Durrat Al Bahrain', '2023-11-21 08:19:07', NULL),
(12, 5, 'Al Dur', '2023-11-21 08:19:22', NULL),
(13, 5, 'Nakhal', '2023-11-21 08:19:32', NULL),
(14, 5, 'Wadi Al Mawaal', '2023-11-21 08:19:47', NULL),
(15, 5, 'Al Awabi', '2023-11-21 08:19:59', NULL),
(16, 5, 'Al Musannah', '2023-11-21 08:20:13', NULL),
(17, 5, 'Barka', '2023-11-21 08:20:21', NULL),
(18, 5, 'Rustaq', '2023-11-21 08:20:29', NULL),
(19, 5, 'Aali', '2023-11-21 08:20:37', NULL),
(20, 5, 'Isa Town', '2023-11-21 08:20:47', NULL),
(21, 5, 'Jurdab', '2023-11-21 08:20:55', NULL),
(22, 5, 'Nasfah', '2023-11-21 08:21:11', NULL),
(23, 5, 'Salmabad', '2023-11-21 08:21:18', NULL),
(24, 5, 'Sanad', '2023-11-21 08:21:31', NULL),
(25, 5, 'Seef', '2023-11-21 08:21:37', NULL),
(26, 5, 'Sitra', '2023-11-21 08:21:46', NULL),
(27, 5, 'Ibri', '2023-11-21 08:21:56', NULL),
(28, 5, 'Yanqul', '2023-11-21 08:22:06', NULL),
(29, 5, 'Dhank', '2023-11-21 08:22:17', NULL),
(30, 5, 'Al Buraimi', '2023-11-21 08:22:27', NULL),
(31, 5, 'Muhadhah', '2023-11-21 08:22:38', NULL),
(32, 5, 'Al Sunainah', '2023-11-21 08:23:01', NULL),
(33, 5, 'Haima', '2023-11-21 08:23:10', NULL),
(34, 5, 'Al Duqum', '2023-11-21 08:23:32', NULL),
(35, 5, 'Mahut', '2023-11-21 08:23:44', NULL),
(36, 5, 'Al Jazir', '2023-11-21 08:23:52', NULL),
(37, 5, 'Amwaj', '2023-11-21 08:24:03', NULL),
(38, 5, 'Arad', '2023-11-21 08:24:16', NULL),
(39, 5, 'Dair', '2023-11-21 08:24:27', NULL),
(40, 5, 'Hidd', '2023-11-21 08:24:35', NULL),
(41, 5, 'Muharraq', '2023-11-21 08:24:52', NULL),
(42, 5, 'Qalali', '2023-11-21 08:25:01', NULL),
(43, 5, 'Abu Saiba', '2023-11-21 08:25:15', NULL),
(44, 5, 'Bani Jamra', '2023-11-21 08:25:26', NULL),
(45, 5, 'Barbar', '2023-11-21 08:25:36', NULL),
(46, 5, 'Budaiya', '2023-11-21 08:25:44', NULL),
(47, 5, 'Buquwa', '2023-11-21 08:26:09', NULL),
(48, 5, 'Salalah', '2023-11-21 08:26:30', NULL),
(49, 5, 'Takah', '2023-11-21 08:26:44', NULL),
(50, 5, 'Marbat', '2023-11-21 08:26:52', NULL),
(51, 5, 'Thamrit', '2023-11-21 08:27:00', NULL),
(52, 5, 'Sadah', '2023-11-21 08:27:15', NULL),
(53, 5, 'Raykhut', '2023-11-21 08:27:22', NULL),
(54, 5, 'Dhalkut', '2023-11-21 08:27:32', NULL),
(55, 5, 'Makshan', '2023-11-21 08:27:45', NULL),
(56, 5, 'Shalim wa Juzar Al Hallan', '2023-11-21 08:27:57', NULL),
(57, 5, 'Al Maziyoona', '2023-11-21 08:28:07', NULL),
(58, 5, 'Khasab', '2023-11-21 08:28:17', NULL),
(59, 5, 'Bakha', '2023-11-21 08:28:31', NULL),
(60, 5, 'Dabaa', '2023-11-21 08:28:43', NULL),
(61, 5, 'Madha', '2023-11-21 08:29:08', NULL),
(62, 5, 'Um Alhassam', '2023-11-21 08:29:26', NULL),
(63, 5, 'Ruwi Office', '2023-11-21 08:29:42', NULL),
(64, 5, 'Musonah Office', '2023-11-21 08:29:50', NULL),
(65, 5, 'Sohar Office', '2023-11-21 08:29:57', NULL),
(66, 5, 'Nizwa Office', '2023-11-21 08:30:04', NULL),
(67, 5, 'Ibri Office', '2023-11-21 08:30:21', NULL),
(68, 5, 'Burimi Office', '2023-11-21 08:30:36', NULL),
(69, 5, 'Sur Office', '2023-11-21 08:30:42', NULL),
(70, 5, 'Ibra Office', '2023-11-21 08:30:49', NULL),
(71, 5, 'Haima Office', '2023-11-21 08:31:00', NULL),
(72, 5, 'Salalah Office', '2023-11-21 08:31:09', NULL),
(73, 5, 'Al-Jaalan Office', '2023-11-21 08:31:22', NULL),
(74, 5, 'Mabilah Office', '2023-11-21 08:31:33', NULL),
(75, 5, 'uae ajman', '2023-11-21 08:31:42', NULL),
(76, 5, 'Adliya', '2023-11-21 08:31:51', NULL),
(77, 5, 'Mahooz/Zinj', '2023-11-21 08:32:03', NULL),
(78, 5, 'AL Burhama', '2023-11-21 08:32:14', NULL),
(79, 5, 'Ghurayfah', '2023-11-21 08:32:20', NULL),
(80, 5, 'Juffair', '2023-11-21 08:32:30', NULL),
(81, 5, 'Manama', '2023-11-21 08:32:49', NULL),
(82, 5, 'Diplomatic Area', '2023-11-21 08:32:58', NULL),
(83, 5, 'Jid ALi', '2023-11-21 08:33:09', NULL),
(84, 5, 'Tubli', '2023-11-21 08:33:18', NULL),
(85, 5, 'Zayed Town', '2023-11-21 08:33:30', NULL),
(86, 5, 'Samaheej', '2023-11-21 08:34:04', NULL),
(87, 5, 'Tala Island', '2023-11-21 08:35:16', NULL),
(88, 5, 'Diyyar Al Muharraq', '2023-11-21 08:35:23', NULL),
(89, 5, 'Dilmunia islands', '2023-11-21 08:35:32', NULL),
(90, 5, 'Buri', '2023-11-21 08:35:42', NULL),
(91, 5, 'Dar Kulaib', '2023-11-21 08:35:52', NULL),
(92, 5, 'Diraz', '2023-11-21 08:35:59', NULL),
(93, 5, 'Dumistan', '2023-11-21 08:36:06', NULL),
(94, 5, 'Hajar', '2023-11-21 08:36:13', NULL),
(95, 5, 'Hamad Town', '2023-11-21 08:36:29', NULL),
(96, 5, 'Hamala', '2023-11-21 08:36:37', NULL),
(97, 5, 'Hillat Abdulsaleh', '2023-11-21 08:36:44', NULL),
(98, 5, 'Janabiya', '2023-11-21 08:36:54', NULL),
(99, 5, 'Jannusan', '2023-11-21 08:37:01', NULL),
(100, 5, 'Jasra', '2023-11-21 08:37:11', NULL),
(101, 5, 'Jiblat Habshi', '2023-11-21 08:37:30', NULL),
(102, 5, 'Jid Alhaj', '2023-11-21 08:37:43', NULL),
(103, 5, 'Jidhafs', '2023-11-21 08:37:52', NULL),
(104, 5, 'Karrana', '2023-11-21 08:37:59', NULL),
(105, 5, 'Karzakan', '2023-11-21 08:38:21', NULL),
(106, 5, 'Khamis, Bilad', '2023-11-21 08:38:38', NULL),
(107, 5, 'Malikiya', '2023-11-21 08:38:48', NULL),
(108, 5, 'Markh', '2023-11-21 08:38:57', NULL),
(109, 5, 'Magasha', '2023-11-21 08:39:08', NULL),
(110, 5, 'Muqaba', '2023-11-21 08:39:19', NULL),
(111, 5, 'Musalla', '2023-11-21 08:39:26', NULL),
(112, 5, 'North Sehla', '2023-11-21 08:39:37', NULL),
(113, 5, 'Qadam', '2023-11-21 08:39:44', NULL),
(114, 5, 'Quraya', '2023-11-21 08:39:54', NULL),
(115, 5, 'Saar', '2023-11-21 08:40:01', NULL),
(116, 5, 'Sadad', '2023-11-21 08:40:07', NULL),
(117, 5, 'Sakheir', '2023-11-21 08:40:18', NULL),
(118, 5, 'Shahrakan', '2023-11-21 08:40:31', NULL),
(119, 5, 'Shakhura', '2023-11-21 08:40:38', NULL),
(120, 5, 'South Sehla', '2023-11-21 08:40:48', NULL),
(121, 5, 'Tashan', '2023-11-21 08:40:56', NULL),
(122, 5, 'Zallaq', '2023-11-21 08:41:15', NULL),
(123, 5, 'Northern City', '2023-11-21 08:41:25', NULL),
(124, 5, 'Askar', '2023-11-21 08:41:31', NULL),
(125, 5, 'Alba', '2023-11-21 08:41:42', NULL),
(126, 5, 'Al Jaw', '2023-11-21 08:41:50', NULL),
(127, 5, 'Ras Zuwaid', '2023-11-21 08:41:59', NULL),
(128, 5, 'Sitra', '2023-11-21 08:42:05', NULL),
(129, 5, 'Nasfah', '2023-11-21 08:42:25', NULL),
(130, 5, 'Durrat Al Bahrain', '2023-11-21 08:42:32', NULL),
(131, 5, 'Qalali', '2023-11-21 08:42:41', NULL),
(132, 5, 'Muharraq', '2023-11-21 08:42:49', NULL),
(133, 5, 'Busaiteen', '2023-11-21 08:42:59', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ship_divisions`
--

CREATE TABLE `ship_divisions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `division_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ship_divisions`
--

INSERT INTO `ship_divisions` (`id`, `division_name`, `created_at`, `updated_at`) VALUES
(5, 'Oman', '2023-11-18 14:00:07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `site_settings`
--

CREATE TABLE `site_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `phone_one` varchar(255) DEFAULT NULL,
  `phone_two` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `company_address` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `linkedin` varchar(255) DEFAULT NULL,
  `youtube` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_settings`
--

INSERT INTO `site_settings` (`id`, `logo`, `phone_one`, `phone_two`, `email`, `company_name`, `company_address`, `facebook`, `twitter`, `linkedin`, `youtube`, `created_at`, `updated_at`) VALUES
(1, 'upload/logo/1781463119031562.png', '01025786389', '01144051604', 'abdosoliman968@gmail.com', 'pharmastoreom', 'oman', NULL, NULL, NULL, NULL, NULL, '2023-11-02 12:33:42');

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slider_img` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `slider_img`, `title`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'upload/slider/1782000594117488.jpeg', 'Pharma Store', 'Less price & High Quality', 0, NULL, '2023-11-09 07:17:50'),
(2, 'upload/slider/1782819363429536.png', 'Pharma Store OM', 'Easy Shoping & Easy Pay', 1, NULL, '2023-11-17 11:50:38'),
(3, 'upload/slider/1782819379176582.png', 'Pharma Store OM', 'Easy Shoping & Easy Pay', 1, NULL, '2023-11-17 11:50:52');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory_name_en` varchar(255) NOT NULL,
  `subcategory_name_ar` varchar(255) NOT NULL,
  `subcategory_slug_en` varchar(255) NOT NULL,
  `subcategory_slug_ar` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `category_id`, `subcategory_name_en`, `subcategory_name_ar`, `subcategory_slug_en`, `subcategory_slug_ar`, `created_at`, `updated_at`) VALUES
(12, 5, 'vitamins', 'فيتامينات', 'vitamins', 'فيتامينات', NULL, NULL),
(13, 5, 'poweful', 'مقويات', 'poweful', 'مقويات', NULL, NULL),
(14, 5, 'treatment', 'تغذيه', 'treatment', 'تغذيه', NULL, NULL),
(15, 2, 'Medicine', 'دواء اطفال', 'medicine', 'دواء-اطفال', NULL, NULL),
(16, 2, 'stomach', 'المعده', 'stomach', 'المعده', NULL, NULL),
(17, 6, 'MOsaken', 'مسكنات', 'mosaken', 'مسكنات', NULL, NULL),
(18, 6, 'Stomach  Pain', 'الام المعده', 'stomach--pain', 'الام-المعده', NULL, NULL),
(19, 4, 'Temperature Check', 'فحص الحراره', 'temperature-check', 'فحص-الحراره', NULL, NULL),
(20, 4, 'kmama', 'كمامة', 'kmama', 'كمامة', NULL, NULL),
(21, 1, 'cleaners', 'ادوات نظافة', 'cleaners', 'ادوات-نظافة', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `testominals`
--

CREATE TABLE `testominals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `testominal_name` varchar(255) DEFAULT NULL,
  `testominal_img` varchar(255) DEFAULT NULL,
  `testominal_title` varchar(255) DEFAULT NULL,
  `testominal_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `testominals`
--

INSERT INTO `testominals` (`id`, `testominal_name`, `testominal_img`, `testominal_title`, `testominal_description`, `created_at`, `updated_at`) VALUES
(2, 'Abdelrahman Soliman', 'upload/testominal/1782076664014458.jpeg', 'Developer', 'Back-End developer in Pharma Store Om', NULL, NULL),
(3, 'Abdelrahman Soliman', 'upload/testominal/1782076682553733.jpeg', 'Developer', 'Back-End developer in Pharma Store Om', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `last_seen` varchar(255) DEFAULT NULL,
  `profile_photo_path` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `last_seen`, `profile_photo_path`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(4, 'Abdelrahman Soliman', 'abdosoliman968@gmail.com', '+201025786389', NULL, NULL, NULL, '$2y$10$g8M5Ri70fy/btXEbDXuqReey46svGkKpBbFbHCJpDEByC23DOu8gW', NULL, '2023-11-24 09:01:38', '2023-11-24 09:01:38'),
(5, 'hager12', 'hager@gmail.com', '01128040819', NULL, NULL, NULL, '$2y$10$whuuyi9aTjdbGv81UWn30OlicF4OWmFD90LMCbu62M0nlSUokOHUa', NULL, '2023-12-25 14:01:20', '2023-12-25 14:01:20'),
(6, 'hager12', 'hagerr@gmail.com', '01128040819', '2023-12-27 14:45:15', NULL, NULL, '$2y$10$s9kXd1ewoAOCHxnQcMoWUewflSENppAZ.AfQWLAL1SEMIbJ239L8G', NULL, '2023-12-27 12:41:58', '2023-12-27 12:45:15');

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wishlists`
--

INSERT INTO `wishlists` (`id`, `user_id`, `product_id`, `created_at`, `updated_at`) VALUES
(5, 1, 8, '2023-11-16 18:57:19', '2023-11-16 18:57:19'),
(6, 1, 5, '2023-11-16 18:58:57', '2023-11-16 18:58:57'),
(7, 1, 9, '2023-11-16 19:03:16', '2023-11-16 19:03:16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_post_categories`
--
ALTER TABLE `blog_post_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `multi_images`
--
ALTER TABLE `multi_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_product_id_foreign` (`product_id`),
  ADD KEY `reviews_user_id_foreign` (`user_id`);

--
-- Indexes for table `seos`
--
ALTER TABLE `seos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shippings`
--
ALTER TABLE `shippings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ship_districts`
--
ALTER TABLE `ship_districts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ship_divisions`
--
ALTER TABLE `ship_divisions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testominals`
--
ALTER TABLE `testominals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `blog_posts`
--
ALTER TABLE `blog_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `blog_post_categories`
--
ALTER TABLE `blog_post_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `multi_images`
--
ALTER TABLE `multi_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `seos`
--
ALTER TABLE `seos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `shippings`
--
ALTER TABLE `shippings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ship_districts`
--
ALTER TABLE `ship_districts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- AUTO_INCREMENT for table `ship_divisions`
--
ALTER TABLE `ship_divisions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `site_settings`
--
ALTER TABLE `site_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `testominals`
--
ALTER TABLE `testominals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
