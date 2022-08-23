@echo THIS COMMAND WILL DELETE [ALL] CONTAINERS
@echo Press [ENTER] to continue or [CTRL+C] to cancel
pause > nul

for /F %%c in ('docker ps -a -q') do (docker stop %%c)
for /F %%c in ('docker ps -a -q') do (docker rm %%c)