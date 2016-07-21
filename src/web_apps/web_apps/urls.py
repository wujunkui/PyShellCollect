"""web_apps URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.8/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add an import:  from blog import urls as blog_urls
    2. Add a URL to urlpatterns:  url(r'^blog/', include(blog_urls))
"""
from django.conf.urls import include, url
from django.contrib import admin
import settings
from count import views

urlpatterns = [
    # url(r'^admin/', include(admin.site.urls)),
    url( r'^static/(?P<path>.*)$', 'django.views.static.serve',{ 'document_root': settings.STATIC_URL }),
    url(r'^bills/info$', views.show_data),
    url(r'^$', views.test),
    url(r'^bills/upload$', views.insert_data),
    url(r'^bills/delete/id=(\d+)', views.delet_data),
]
