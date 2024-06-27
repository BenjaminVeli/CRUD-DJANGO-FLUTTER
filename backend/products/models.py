from django.db import models

class Product(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    stock = models.IntegerField(default=0)
    date = models.DateField()
    in_stock = models.BooleanField()
    
    def __str__(self):
        return self.name

