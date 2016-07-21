from django.db import models

# Create your models here.
class Bill(models.Model):
    date = models.DateField(max_length=10)
    action = models.CharField(max_length=30)
    cast = models.FloatField(max_length=20)
