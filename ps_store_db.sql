/* Пункт 3 */
create schema ps_store;

set search_path = ps_store;

drop table STUDIO_X_GAME;
drop table SPECIAL_OFFER_X_GAME;
drop table STUDIO;
drop table PURCHASE;
drop table SALE;
drop table SPECIAL_OFFER;
drop table GAME;
drop table USERS;

create table GAME (
  game_id   int   primary key ,
  game_nm   varchar(50)   not null ,
  game_full_price_atm   real   not null default 0 check ( game_full_price_atm >=0 ),
  description_txt    text ,
  genre_nm    varchar(20) ,
  pegi    int   not null check ( pegi >= 0 )
);

create table STUDIO (
  studio_id   int   primary key ,
  studio_nm   varchar(50)   not null
);

create table SALE (
  sale_id   int   primary key ,
  sale_nm   varchar(30) ,
  sale_start_dttm   timestamp ,
  sale_end_dttm   timestamp
);

create table USERS (
  user_id   int   primary key ,
  user_nm   varchar(20)   not null ,
  birth_dt  date  not null not null,
  bank_card_num varchar(19) not null check ( bank_card_num like '____-____-____-____')
);

create table SPECIAL_OFFER (
  special_offer_id  int   primary key ,
  user_id   int   references USERS(user_id) ,
  special_offer_nm  varchar(30) ,
  special_offer_start_dttm    timestamp ,
  special_offer_end_dttm    timestamp
);

create table PURCHASE (
  transaction_id   int   primary key ,
  user_id   int   not null    references USERS(user_id) ,
  sale_id   int   references SALE(sale_id) ,
  special_offer_id  int   references SPECIAL_OFFER(special_offer_id) ,
  game_id   int   references GAME(game_id) ,
  game_final_price_amt  real  not null default 0 check ( game_final_price_amt >= 0 ) ,
  time_of_transaction_dttm    timestamp
);

create table SPECIAL_OFFER_X_GAME (
  special_offer_id    int   references SPECIAL_OFFER(special_offer_id) ,
  game_id    int    references GAME(game_id) ,
  game_price_amt   real   not null default 0 check ( game_price_amt >= 0 ),
  constraint pk_special_offer_x_game primary key (special_offer_id, game_id)
);

create table STUDIO_X_GAME(
  studio_id    int   references STUDIO(studio_id) ,
  game_id    int   references GAME(game_id),
  constraint pk_studio_x_game primary key (studio_id, game_id)
);

create table  SALE_X_GAME (
  sale_id   int   references SALE(sale_id) ,
  game_id   int   references GAME(game_id) ,
  game_price_amt   real   not null default 0 check ( game_price_amt >= 0 ),
  constraint pk_sale_x_game primary key (sale_id, game_id)
);

/* Пункт 4 */
insert into GAME values (1, 'Uncharted 3', 1990.0, 'Лучшая игра из всех, что вы знали!', 'adventure', 16);
insert into GAME values (2, 'GTA 5', 3990.0, 'Погрузитесь в истории Майкла, Франклина и Тревора, трех непохожих ' ||
                                             'преступников, которые решили поставить на карту все и провернуть ' ||
                                             'серию дерзких и опасных ограблений с риском угодить за решетку ' ||
                                             'до конца своих дней.', 'action-adventure', 18);
insert into GAME values (3, 'Battlefield 4', 1599.0, 'Battlefield 4 – это образцовый блокбастер в жанре экшн, состоящий' ||
                                                    ' из незабываемых моментов, стирающих грань между игрой и ' ||
                                                    'славой.', 'shooter', 18);
insert into GAME values (4, 'Knack', 2599.0, 'Приключения ждут Только герой поневоле Нэк может спасти человечество от ' ||
                                             'безжалостной армии гоблинов. Пустите в ход впечатляющую мощь Нэка,' ||
                                             ' чтобы превратить его в гигантскую боевую машину, сражайтесь с врагами и ' ||
                                             'проникните в тайну, которая потрясет весь мир.', 'adventure', 12);
insert into GAME values (5, 'The Last of Us', 2999.0, 'Во враждебном, опустошенном эпидемией мире Джоэл и Элли, которых ' ||
                                                     'трагическая судьба свела вместе, могут полагаться только друг на ' ||
                                                     'друга, чтобы пережить полное опасностей путешествие по территории ' ||
                                                     'бывших Соединенных Штатов.', 'adventure',  18);

insert into GAME values (6, 'Assassin''s Creed Origins', 3999.0, 'Раскройте тайны Древнего Египта и узнайте, как было ' ||
                                                                 'создано Братство ассасинов.', 'action-adventure', 18);

insert into GAME values (7, 'LittleBigPlanet 3', 2999.0, 'Применяйте уникальные способности Сэкбоя и его новых друзей - ' ||
                                                         'Тоггла, Оддсока и Свупа, чтобы исследовать каждый уголок Мира ' ||
                                                         'воображения и раскрыть тайну планеты Бредум. А после - ' ||
                                                         'откройте для себя потрясающие новые уровни и игры, созданными' ||
                                                         ' участниками сообщества LittleBigPlanet!', 'platformer', 6);

insert into STUDIO values (8, 'Ubisoft Montreal');
insert into STUDIO values (9, 'Sony Interactive Entertainment Europe');
insert into STUDIO values (10, 'Sumo Digital');
insert into STUDIO values (11, 'Naughty Dog');
insert into STUDIO values (12, 'Electronic Arts');
insert into STUDIO values (13, 'DICE');
insert into STUDIO values (14, 'Rockstar');

insert into STUDIO_X_GAME values (11, 1);
insert into STUDIO_X_GAME values (11, 5);
insert into STUDIO_X_GAME values (9, 1);
insert into STUDIO_X_GAME values (9, 5);
insert into STUDIO_X_GAME values (14, 2);
insert into STUDIO_X_GAME values (13, 3);
insert into STUDIO_X_GAME values (12, 3);
insert into STUDIO_X_GAME values (8, 6);
insert into STUDIO_X_GAME values (10, 7);
insert into STUDIO_X_GAME values (9, 7);


insert into USERS values (15, 'vit@liy', '1999-12-05', '5404-3690-3327-9118');
insert into USERS values (16, 'vasya2001', '2001-03-09', '5404-3646-7927-6585');
insert into USERS values (17, 'kill-pig', '2005-01-04', '4363-7776-5478-2693');
insert into USERS values (18, 'monsterrrr', '1979-02-16', '5404-3652-1723-8805');
insert into USERS values (19, 'WiLlEr', '1951-04-13', '4882-2005-0992-7324');
insert into USERS values (20, 'KingTheKing', '2000-03-06', '4165-6048-2937-1717');
insert into USERS values (21, 'v.v.p', '2000-03-06', '4205-5739-6552-6552');

insert into SALE values (22, 'Убойные праздники', '2019-05-01', '2019-05-05');
insert into SALE values (23, 'Новогодние каникулы', '2019-01-01', '2019-01-08');
insert into SALE values (24, 'Дети тоже игроки', '2019-02-24', '2019-02-28');
insert into SALE values (25, 'Шутки в сторону', '2019-03-30', '2019-04-02');
insert into SALE values (26, 'Это лето', '2018-06-01', '2018-06-12');
insert into SALE values (27, 'Снова в ...', '2018-09-01', '2018-09-30');

insert into SALE_X_GAME values (22, 1, 1599.9);
insert into SALE_X_GAME values (22, 3, 599.9);
insert into SALE_X_GAME values (22, 6, 2799.9);
insert into SALE_X_GAME values (23, 2, 2599.9);
insert into SALE_X_GAME values (23, 5, 1899.9);
insert into SALE_X_GAME values (23, 7, 2599.9);
insert into SALE_X_GAME values (24, 4, 1249.9);
insert into SALE_X_GAME values (24, 7, 1499.9);
insert into SALE_X_GAME values (25, 4, 899.9);
insert into SALE_X_GAME values (26, 5, 1499.9);
insert into SALE_X_GAME values (26, 1, 999.9);
insert into SALE_X_GAME values (26, 7, 1999.9);
insert into SALE_X_GAME values (27, 3, 999.9);
insert into SALE_X_GAME values (27, 6, 3599.9);

insert into SPECIAL_OFFER values (28, 15, 'Подарок судьбы', '2019-02-01', '2019-02-28');
insert into SPECIAL_OFFER values (29, 16, 'С днём рождения!', '2019-03-01', '2019-03-14');
insert into SPECIAL_OFFER values (30, 17, 'С днём защиты детей!', '2018-06-01', '2018-06-12');
insert into SPECIAL_OFFER values (31, 18, 'Для тех, кто давно с нами', '2019-03-28', '2019-04-20');
insert into SPECIAL_OFFER values (32, 19, 'Для тех, кто давно с нами', '2019-03-28', '2019-04-20');
insert into SPECIAL_OFFER values (33, 20, 'С днём студента!', '2019-01-20', '2019-01-28');
insert into SPECIAL_OFFER values (34, 21, 'Феврали ваш!', '2019-02-01', '2019-02-28');
insert into SPECIAL_OFFER values (35, 19, 'Почётный игрок', '2018-08-27', '2019-09-15');

insert into SPECIAL_OFFER_X_GAME values (28, 1, 990);
insert into SPECIAL_OFFER_X_GAME values (28, 2, 1990);
insert into SPECIAL_OFFER_X_GAME values (29, 4, 499);
insert into SPECIAL_OFFER_X_GAME values (29, 6, 1499);
insert into SPECIAL_OFFER_X_GAME values (30, 7, 1299);
insert into SPECIAL_OFFER_X_GAME values (30, 4, 799);
insert into SPECIAL_OFFER_X_GAME values (31, 2, 1799);
insert into SPECIAL_OFFER_X_GAME values (31, 3, 499);
insert into SPECIAL_OFFER_X_GAME values (31, 5, 899);
insert into SPECIAL_OFFER_X_GAME values (32, 2, 1799);
insert into SPECIAL_OFFER_X_GAME values (32, 3, 499);
insert into SPECIAL_OFFER_X_GAME values (32, 5, 899);
insert into SPECIAL_OFFER_X_GAME values (33, 2, 2899);
insert into SPECIAL_OFFER_X_GAME values (33, 6, 2899);
insert into SPECIAL_OFFER_X_GAME values (33, 5, 1899);
insert into SPECIAL_OFFER_X_GAME values (34, 7, 1899);
insert into SPECIAL_OFFER_X_GAME values (34, 6, 1899);
insert into SPECIAL_OFFER_X_GAME values (34, 2, 1899);
insert into SPECIAL_OFFER_X_GAME values (34, 5, 1899);
insert into SPECIAL_OFFER_X_GAME values (35, 2, 899);

insert into PURCHASE values (36, 15, null, null, 1, 1990, '2018-12-31 13:03:00');
insert into PURCHASE values (37, 15, 25, null, 4, 899.9, '2019-04-01 03:23:15');
insert into PURCHASE values (38, 16, null, 29, 6, 1499, '2018-03-13 23:59:59');
insert into PURCHASE values (39, 16, 23, null, 5, 1899.9, '2018-01-02 14:53:18');
insert into PURCHASE values (40, 17, null, 30, 7, 1299, '2018-06-02 17:04:30');
insert into PURCHASE values (41, 17, 24, null, 4, 1249.9, '2019-01-25 21:09:20');
insert into PURCHASE values (42, 18, null, null, 5, 2990, '2018-11-30 16:03:00');
insert into PURCHASE values (43, 19, null, 35, 2, 899, '2018-08-30 18:13:50');
insert into PURCHASE values (44, 20, 27, null, 3, 599.9, '2018-09-04 20:34:10');
insert into PURCHASE values (45, 21, null, null, 3, 1599, '2018-10-31 16:16:06');
insert into PURCHASE values (46, 20, null, 33, 2, 2899, '2018-01-25 9:03:08');
insert into PURCHASE values (47, 19, 22, null, 6, 2799.9, '2019-05-02 04:03:09');


/* Пункт 5 */

/* 1) Хотим: узнать, какие скидки не были интересны пользователям */
select t.sale_nm
from
  (select sl.sale_nm
    from SALE sl
  except
  select sl_join.sale_nm
    from SALE sl_join
    inner join PURCHASE P on sl_join.sale_id = P.sale_id) t;

/* 2) Хотим: узнать, в какой период каждая из игр в магазине стоила меньше всего
 (для всех пользователей) */
select distinct
  game_nm,
  first_value(game_price) over (partition by game_nm order by game_price),
  first_value(sale_start_dttm) over (partition by game_nm order by game_price),
  first_value(sale_end_dttm) over (partition by game_nm order by game_price)
from
  (select g.game_nm, sale_start_dttm, sale_end_dttm,
    (case when SXG.sale_id is null
      then g.game_full_price_atm
      else SXG.game_price_amt
      end) as game_price
  from
    GAME g
  left join
    SALE_X_GAME SXG on g.game_id = SXG.game_id
  inner join
    SALE S on SXG.sale_id = S.sale_id) t;


