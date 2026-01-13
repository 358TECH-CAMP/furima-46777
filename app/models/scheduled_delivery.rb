class ScheduledDelivery < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' }, # id: 0 を 1 に変更
    { id: 2, name: '1〜2日で発送' }, # id: 1 を 2 に変更
    { id: 3, name: '2〜3日で発送' }, # id: 2 を 3 に変更
    { id: 4, name: '4〜7日で発送' }  # id: 3 を 4 に変更
  ]
end
