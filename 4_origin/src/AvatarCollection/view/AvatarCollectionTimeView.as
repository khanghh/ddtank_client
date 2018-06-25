package AvatarCollection.view
{
   import AvatarCollection.AvatarCollectionManager;
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class AvatarCollectionTimeView extends Sprite implements Disposeable
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _btnDelayTime:SimpleBitmapButton;
      
      private var _btnSelectAll:SimpleBitmapButton;
      
      private var _btnUnSelectAll:SimpleBitmapButton;
      
      private var _timer:TimerJuggler;
      
      private var _data:AvatarCollectionUnitVo;
      
      private var _needHonor:int;
      
      public function AvatarCollectionTimeView()
      {
         super();
         this.x = 202;
         this.y = 391;
         initView();
         initEvent();
         initTimer();
         setDefaultView();
      }
      
      private function initView() : void
      {
         _txt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.timeView.txt");
         _btnSelectAll = ComponentFactory.Instance.creatComponentByStylename("avatarColl.selectAll.btn");
         _btnUnSelectAll = ComponentFactory.Instance.creatComponentByStylename("avatarColl.unSelectAll.btn");
         _btnUnSelectAll.visible = false;
         _btnDelayTime = ComponentFactory.Instance.creatComponentByStylename("avatarColl.timeView.btn");
         addChild(_txt);
         addChild(_btnSelectAll);
         addChild(_btnUnSelectAll);
         addChild(_btnDelayTime);
      }
      
      private function initEvent() : void
      {
         _btnDelayTime.addEventListener("click",delayTimeClickHandler,false,0,true);
         _btnSelectAll.addEventListener("click",selectAllClickHandler);
         _btnUnSelectAll.addEventListener("click",unSelectAllClickHandler);
         AvatarCollectionManager.instance.addEventListener("avatar_collection_select_all",onSetSelectedAll);
      }
      
      protected function onSetSelectedAll(e:CEvent) : void
      {
         var bool:Boolean = e.data;
         _btnSelectAll.visible = !bool;
         _btnUnSelectAll.visible = bool;
      }
      
      protected function unSelectAllClickHandler(e:MouseEvent) : void
      {
         onSelectChange();
      }
      
      protected function selectAllClickHandler(e:MouseEvent) : void
      {
         onSelectChange();
      }
      
      public function onSelectChange() : void
      {
         SoundManager.instance.play("008");
         _btnSelectAll.visible = !_btnSelectAll.visible;
         _btnUnSelectAll.visible = !_btnUnSelectAll.visible;
         AvatarCollectionManager.instance.selectAllClicked();
      }
      
      public function set selected(value:Boolean) : void
      {
         _btnSelectAll.visible = !value;
         _btnUnSelectAll.visible = value;
      }
      
      private function delayTimeClickHandler(event:MouseEvent) : void
      {
         var msgString:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _needHonor = AvatarCollectionManager.instance.honourNeedTotalPerDay();
         if(_needHonor == 0)
         {
            msgString = LanguageMgr.GetTranslation("avatarCollection.selectOne");
            MessageTipManager.getInstance().show(msgString,0,false,1);
            return;
         }
         var count:int = PlayerManager.Instance.Self.myHonor / _needHonor;
         var alert:AvatarCollectionDelayConfirmFrame = ComponentFactory.Instance.creatComponentByStylename("avatarColl.delayConfirmFrame");
         alert.show(_needHonor,count);
         alert.addEventListener("response",__onConfirmResponse);
         LayerManager.Instance.addToLayer(alert,3,true,1);
      }
      
      protected function __onConfirmResponse(event:FrameEvent) : void
      {
         var tmpValue:int = 0;
         SoundManager.instance.play("008");
         var alert:AvatarCollectionDelayConfirmFrame = event.currentTarget as AvatarCollectionDelayConfirmFrame;
         alert.removeEventListener("response",__onConfirmResponse);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            tmpValue = alert.selectValue;
            if(PlayerManager.Instance.Self.myHonor < _needHonor * tmpValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("avatarCollection.delayConfirmFrame.noEnoughHonor"));
            }
            else
            {
               AvatarCollectionManager.instance.delayTheTimeConfirmed(tmpValue);
            }
         }
         alert.dispose();
      }
      
      private function initTimer() : void
      {
         _timer = TimerManager.getInstance().addTimerJuggler(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
      }
      
      private function timerHandler(event:Event) : void
      {
         refreshTimePlayTxt();
      }
      
      public function refreshView(data:AvatarCollectionUnitVo) : void
      {
         _data = data;
         if(!_data)
         {
            setDefaultView();
            _timer.stop();
            return;
         }
         var totalCount:int = _data.totalItemList.length;
         var activityCount:int = _data.totalActivityItemCount;
         if(activityCount < totalCount / 2)
         {
            setDefaultView();
            _timer.stop();
            return;
         }
         _btnDelayTime.enable = true;
         _btnSelectAll.enable = true;
         refreshTimePlayTxt();
         _timer.start();
      }
      
      private function refreshTimePlayTxt() : void
      {
         var timeTxtStr:* = null;
         var endTimestamp:Number = _data.endTime.getTime();
         var nowTimestamp:Number = TimeManager.Instance.Now().getTime();
         var differ:Number = endTimestamp - nowTimestamp;
         differ = differ < 0?0:Number(differ);
         var count:int = 0;
         if(differ / 86400000 > 1)
         {
            count = differ / 86400000;
            timeTxtStr = count + LanguageMgr.GetTranslation("day");
         }
         else if(differ / 3600000 > 1)
         {
            count = differ / 3600000;
            timeTxtStr = count + LanguageMgr.GetTranslation("hour");
         }
         else if(differ / 60000 > 1)
         {
            count = differ / 60000;
            timeTxtStr = count + LanguageMgr.GetTranslation("minute");
         }
         else
         {
            count = differ / 1000;
            timeTxtStr = count + LanguageMgr.GetTranslation("second");
         }
         _txt.text = LanguageMgr.GetTranslation("avatarCollection.timeView.txt") + timeTxtStr;
      }
      
      private function setDefaultView() : void
      {
         _txt.text = LanguageMgr.GetTranslation("avatarCollection.timeView.txt") + 0 + LanguageMgr.GetTranslation("day");
      }
      
      private function removeEvent() : void
      {
         _btnDelayTime.removeEventListener("click",delayTimeClickHandler);
         _btnSelectAll.removeEventListener("click",selectAllClickHandler);
         _btnUnSelectAll.removeEventListener("click",unSelectAllClickHandler);
         AvatarCollectionManager.instance.removeEventListener("avatar_collection_select_all",onSetSelectedAll);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timerHandler);
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
         }
         ObjectUtils.disposeAllChildren(this);
         _txt = null;
         _btnDelayTime = null;
         _timer = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
