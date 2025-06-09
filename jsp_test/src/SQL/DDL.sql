-- 회원 테이블
DROP TABLE IF EXISTS `user` CASCADE;
create table `user` (
	id varchar(10) not null COMMENT '회원 아이디',		-- 회원 아이디
	password varchar(10) not null COMMENT '비밀번호',	-- 비밀번호
	name varchar(10) not null COMMENT '이름',		-- 이름
	gender varchar(5) COMMENT '성별',				-- 성별
	birth varchar(10) COMMENT '생일',				-- 생일
	mail varchar(30) COMMENT '메일',				-- 메일
	phone varchar(20) COMMENT '전화번호',				-- 전화번호
	address varchar(90) COMMENT '주소',			-- 주소
	regist_day timestamp default now() COMMENT '가입일자',		-- 가입일자
	primary key(id)
) COMMENT '회원';

-- 자동 로그인 테이블
DROP TABLE IF EXISTS `persistent_logins` CASCADE;
CREATE TABLE `persistent_logins` (
  `p_no` int NOT NULL AUTO_INCREMENT COMMENT '자동 로그인 번호',
  `user_id` varchar(255) NOT NULL COMMENT '회원 아이디',
  `token` varchar(255) NOT NULL COMMENT '토큰',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일자',
  PRIMARY KEY (`p_no`),
  UNIQUE KEY `unique_token` (`token`)
) COMMENT '자동 로그인';


-- 상품 테이블
DROP TABLE IF EXISTS `product` CASCADE;

CREATE TABLE product (
	product_id varchar(100) NOT NULL COMMENT '상품ID',
	name varchar(100) NOT NULL COMMENT '상품명',
	unit_price INT NULL COMMENT '가격(단가)',
	description TEXT NULL COMMENT '설명',
	manufacturer varchar(100) NULL COMMENT '제조업체',
	category varchar(100) NULL COMMENT '카테고리',
	units_in_stock INT DEFAULT 0 NOT NULL COMMENT '재고 수',
	`condition` varchar(100) NULL COMMENT '상태',
	file TEXT NULL COMMENT '파일경로',
	quantity INT DEFAULT 0 NOT NULL COMMENT '장바구니 개수', 
	CONSTRAINT product_pk PRIMARY KEY (product_id)
) COMMENT '상품';


DROP TABLE IF EXISTS `order` CASCADE;
CREATE TABLE `order` (
  `order_no` int NOT NULL AUTO_INCREMENT COMMENT '주문번호',
  `ship_name` varchar(100) NOT NULL COMMENT '받는사람이름',
  `zip_code` varchar(100) NOT NULL COMMENT '우편번호',
  `country` varchar(100) NOT NULL COMMENT '국가',
  `address` varchar(200) NOT NULL COMMENT '주소',
  `date` varchar(200) NOT NULL COMMENT '배송일자',
  `order_pw` varchar(200) NULL COMMENT '주문 비밀번호',
  `user_id` varchar(10) DEFAULT NULL COMMENT '회원아이디',
  `total_price` int DEFAULT '0' COMMENT '총가격',
  `phone` varchar(20) DEFAULT NULL COMMENT '비회원 전화번호',
  PRIMARY KEY (`order_no`)
) COMMENT='주문';

-- 입출고 테이블
DROP TABLE IF EXISTS `product_io` CASCADE;

CREATE TABLE `product_io` (
  `product_id` varchar(100) NOT NULL COMMENT '상품아이디',
  `order_no` int DEFAULT NULL COMMENT '주문번호',
  `amount` int DEFAULT NULL COMMENT '입출고량',
  `type` varchar(100) DEFAULT NULL COMMENT '입고(IN),출고(OUT)',
  `io_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '입출고날짜',
  `user_id` varchar(10) DEFAULT NULL COMMENT '회원아이디',
  KEY `product_id_FK` (`product_id`),
  KEY `product_id_FK_1` (`order_no`),
  CONSTRAINT `product_id_FK` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `order_no_FK` FOREIGN KEY (`order_no`) REFERENCES `order` (`order_no`)
) COMMENT='상품 입출고';


DROP TABLE IF EXISTS order_item CASCADE;

CREATE TABLE order_item (
    order_no   INT,
    product_id VARCHAR(50),
    quantity   INT,
    PRIMARY KEY (order_no, product_id),
    FOREIGN KEY (order_no) REFERENCES `order`(order_no),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);
