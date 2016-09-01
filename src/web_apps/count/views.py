from django.shortcuts import render
from django.http import HttpResponse,HttpResponseRedirect
from datetime import datetime
from models import Bill

# Create your views here.

def test(request):
    return render(request,'basic.html',{})

def creat_data(date,action,cast):
    bill = Bill()
    # bill.date = datetime.now().date()
    print(type(date))
    if not date:
        bill.date = datetime.now().date()
    else:
        bill.date = datetime.strptime(date,"%m/%d/%Y")
    bill.action = action
    bill.cast = cast
    bill.save()

def show_data(request):
    data_lst = []
    sum_num = 0
    for every in Bill.objects.all():
        data_lst.append({'id':every.id,'date':every.date,
                         'action':every.action,'cast':every.cast})
        sum_num += float(every.cast)

    totle_dic = {'length':len(data_lst),'sum':sum_num}
    return render(request,'basic.html',{'details':data_lst,'totle':totle_dic})

def insert_data(request):
    print(request.POST)
    if request.method == 'POST':
        print('i am in')
        creat_data(request.POST['new_date'],request.POST['new_action'],request.POST['new_cast'])
    return HttpResponseRedirect('/bills/info')

def delet_data(request,id):
    p = Bill.objects.filter(id=id)
    p.delete()
    return HttpResponseRedirect('/bills/info')
