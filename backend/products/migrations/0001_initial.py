# Generated by Django 4.1.7 on 2024-06-27 03:00

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=255)),
                ('stock', models.IntegerField(default=0)),
                ('date', models.DateField()),
                ('in_stock', models.BooleanField()),
            ],
        ),
    ]
