# بیس پروژه را روی یک ایمیج آماده قرار میدیم
FROM ruby:2.5
 
# پکیج‌هایی که لازیم داریم را نصب می‌کنیم
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client
 
# مشخص می‌کنیم پروژه در چه فولدری ریخته شود
ENV RAILS_ROOT /var/www/app
 
# فولدر را می‌سازیم
RUN mkdir -p $RAILS_ROOT
 
# مشخص می‌کنیم فولدر برای اجرای برنامه  کجاست
WORKDIR $RAILS_ROOT
 
# پروژه را به ورکینگ دایرکتوری کپی می‌کنیم
COPY . .

#  خط بعدی برای انتقال و ساخت تمام وابستگی‌های پروژه است. در اپلیکیشن‌های ریلز مدیریت وابستگی‌ها به این شکل تعریف می‌شوند. 
RUN bundle install
 
# وقتی کانتینر را ران می‌کنیم چه دستوری باید ران بشه؟ 
CMD [ "config/app_cmd.sh" ]
