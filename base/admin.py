from django.contrib import admin
from .models import Task

class TaskAdmin(admin.ModelAdmin):
    list_display = ('title', 'user', 'complete', 'created')  # Fields to display in the list view
    list_filter = ('user', 'complete')  # Add filters for user and completion status
    search_fields = ('title', 'description')  # Enable search by title and description

admin.site.register(Task, TaskAdmin)