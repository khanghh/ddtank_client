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
      
      protected function onSetSelectedAll(param1:CEvent) : void
      {
         var _loc2_:Boolean = param1.data;
         _btnSelectAll.visible = !_loc2_;
         _btnUnSelectAll.visible = _loc2_;
      }
      
      protected function unSelectAllClickHandler(param1:MouseEvent) : void
      {
         onSelectChange();
      }
      
      protected function selectAllClickHandler(param1:MouseEvent) : void
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
      
      public function set selected(param1:Boolean) : void
      {
         _btnSelectAll.visible = !param1;
         _btnUnSelectAll.visible = param1;
      }
      
      private function delayTimeClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _needHonor = AvatarCollectionManager.instance.honourNeedTotalPerDay();
         if(_needHonor == 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("avatarCollection.selectOne");
            MessageTipManager.getInstance().show(_loc3_,0,false,1);
            return;
         }
         var _loc2_:int = PlayerManager.Instance.Self.myHonor / _needHonor;
         var _loc4_:AvatarCollectionDelayConfirmFrame = ComponentFactory.Instance.creatComponentByStylename("avatarColl.delayConfirmFrame");
         _loc4_.show(_needHonor,_loc2_);
         _loc4_.addEventListener("response",__onConfirmResponse);
         LayerManager.Instance.addToLayer(_loc4_,3,true,1);
      }
      
      protected function __onConfirmResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:AvatarCollectionDelayConfirmFrame = param1.currentTarget as AvatarCollectionDelayConfirmFrame;
         _loc3_.removeEventListener("response",__onConfirmResponse);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            _loc2_ = _loc3_.selectValue;
            if(PlayerManager.Instance.Self.myHonor < _needHonor * _loc2_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("avatarCollection.delayConfirmFrame.noEnoughHonor"));
            }
            else
            {
               AvatarCollectionManager.instance.delayTheTimeConfirmed(_loc2_);
            }
         }
         _loc3_.dispose();
      }
      
      private function initTimer() : void
      {
         _timer = TimerManager.getInstance().addTimerJuggler(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
      }
      
      private function timerHandler(param1:Event) : void
      {
         refreshTimePlayTxt();
      }
      
      public function refreshView(param1:AvatarCollectionUnitVo) : void
      {
         _data = param1;
         if(!_data)
         {
            setDefaultView();
            _timer.stop();
            return;
         }
         var _loc3_:int = _data.totalItemList.length;
         var _loc2_:int = _data.totalActivityItemCount;
         if(_loc2_ < _loc3_ / 2)
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
         var _loc5_:* = null;
         var _loc4_:Number = _data.endTime.getTime();
         var _loc3_:Number = TimeManager.Instance.Now().getTime();
         var _loc1_:Number = _loc4_ - _loc3_;
         _loc1_ = _loc1_ < 0?0:Number(_loc1_);
         var _loc2_:int = 0;
         if(_loc1_ / 86400000 > 1)
         {
            _loc2_ = _loc1_ / 86400000;
            _loc5_ = _loc2_ + LanguageMgr.GetTranslation("day");
         }
         else if(_loc1_ / 3600000 > 1)
         {
            _loc2_ = _loc1_ / 3600000;
            _loc5_ = _loc2_ + LanguageMgr.GetTranslation("hour");
         }
         else if(_loc1_ / 60000 > 1)
         {
            _loc2_ = _loc1_ / 60000;
            _loc5_ = _loc2_ + LanguageMgr.GetTranslation("minute");
         }
         else
         {
            _loc2_ = _loc1_ / 1000;
            _loc5_ = _loc2_ + LanguageMgr.GetTranslation("second");
         }
         _txt.text = LanguageMgr.GetTranslation("avatarCollection.timeView.txt") + _loc5_;
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
