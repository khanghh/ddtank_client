package nationDay.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import dayActivity.event.ActivityEvent;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmModelController;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class ActivitySeedCell extends BagCell
   {
       
      
      private var _id:int;
      
      private var _autumnAnimation:MovieClip;
      
      private var _getAwardAnimation:MovieClip;
      
      private var _seedBtn:BaseButton;
      
      private var _getAwardBtn:BaseButton;
      
      private var _midFlag:Boolean;
      
      public function ActivitySeedCell(id:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         _id = id;
         super(0,info,showLoading,bg,mouseOverEffBoolean);
      }
      
      public function addSeedBtn() : void
      {
         _seedBtn = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.midAutumn.seedButton");
         addChild(_seedBtn);
         _seedBtn.visible = false;
         addEvent();
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__onMouseOver);
         addEventListener("mouseOut",__onMouseOut);
         _seedBtn.addEventListener("click",__onSeedBtnClick);
      }
      
      override public function updateCount() : void
      {
      }
      
      protected function __updateCount(event:BagEvent) : void
      {
      }
      
      protected function __onSeedBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
      }
      
      protected function __onMouseOver(event:MouseEvent) : void
      {
         _seedBtn.visible = true;
      }
      
      protected function __onMouseOut(event:MouseEvent) : void
      {
         _seedBtn.visible = false;
      }
      
      public function addAwardAnimation() : void
      {
         _midFlag = true;
         if(_autumnAnimation)
         {
            return;
         }
         _autumnAnimation = ComponentFactory.Instance.creat("asset.activity.midautumnAnimation");
         addChild(_autumnAnimation);
         _getAwardAnimation = ComponentFactory.Instance.creat("asset.activity.getAwardAnimation");
         PositionUtils.setPos(_getAwardAnimation,"ddtcalendar.midAutumnView.getAwardAnimation");
         addChild(_getAwardAnimation);
         _getAwardAnimation.stop();
         _getAwardBtn = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.midAutumn.getAwardBtn");
         addChild(_getAwardBtn);
         _getAwardBtn.addEventListener("click",__onGetAwardClick);
      }
      
      public function addFireworkAnimation(level:int) : void
      {
         if(_autumnAnimation)
         {
            return;
         }
         _autumnAnimation = ComponentFactory.Instance.creat("asset.activity.nationAnimation");
         addChild(_autumnAnimation);
         _getAwardAnimation = ComponentFactory.Instance.creat("asset.activity.fireworkAnimation" + level);
         PositionUtils.setPos(_getAwardAnimation,"nationDay.fireworkPlayPos0");
         addChild(_getAwardAnimation);
         _getAwardAnimation.stop();
         _getAwardBtn = ComponentFactory.Instance.creatComponentByStylename("nationDay.getAwardBtn");
         addChild(_getAwardBtn);
         _getAwardBtn.addEventListener("click",__onGetAwardClick);
      }
      
      public function removeFireworkAnimation() : void
      {
         if(_autumnAnimation)
         {
            _autumnAnimation.parent.removeChild(_autumnAnimation);
            _autumnAnimation = null;
         }
         if(_getAwardBtn)
         {
            _getAwardBtn.removeEventListener("click",__onGetAwardClick);
            _getAwardBtn.dispose();
            _getAwardBtn = null;
         }
      }
      
      protected function __onGetAwardClick(event:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var evt:ActivityEvent = new ActivityEvent(ActivityEvent.SEND_GOOD);
         evt.id = _id;
         dispatchEvent(evt);
      }
      
      public function playFireworkAnimation() : void
      {
         var i:int = 0;
         _getAwardAnimation.gotoAndPlay("play");
         if(_midFlag)
         {
            SoundManager.instance.play("008");
         }
         else
         {
            SoundManager.instance.play("117");
            for(i = 0; i < 4; )
            {
               if(i == _id)
               {
                  PositionUtils.setPos(_getAwardAnimation,"nationDay.fireworkPlayPos" + i);
                  break;
               }
               i++;
            }
         }
      }
      
      public function get needCount() : int
      {
         return 0;
      }
      
      override public function dispose() : void
      {
         removeEventListener("mouseOver",__onMouseOver);
         removeEventListener("mouseOut",__onMouseOut);
         _autumnAnimation = null;
         _getAwardAnimation = null;
         if(_seedBtn)
         {
            _seedBtn.removeEventListener("click",__onSeedBtnClick);
            _seedBtn.dispose();
            _seedBtn = null;
         }
         if(_getAwardBtn)
         {
            _getAwardBtn.removeEventListener("click",__onGetAwardClick);
            _getAwardBtn.dispose();
            _getAwardBtn = null;
         }
         super.dispose();
      }
   }
}
