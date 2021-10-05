from apscheduler.schedulers.blocking import BlockingScheduler
from datetime import datetime


# 모니터링 시작/종료 주기 : 월~금요일 9시 모니터링 시작, 15시 30분 모니터링 종료.
# 모니터링 체크 주기 : 1분마다/5분마다/10분마다 등등
# 1번 스케줄에서는 2번 스케줄을 시작하거나 종료하게 됩니다. 


# main code
def runner():
    print(f'{datetime.now()}:runner')

sched = BlockingScheduler()

# main job
runner_job = sched.add_job(runner, 'interval', minute=10)

# start job
def start_runner():
    print(f'{datetime.now()}:start_runner')
    runner_job.resume()

# stop job
def stop_runner():
    print(f'{datetime.now()}:stop_runner')
    runner_job.pause()

# to delay main job
stop_runner()
 
# schedules for main job
sched.add_job(start_runner, 'cron', day_of_week='mon-fri', hour='8-21')
sched.add_job(stop_runner, 'cron', day_of_week='fri', hour='22')

sched.start()