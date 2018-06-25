package dreamlandChallenge.view.logicView
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.DungeonInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import dreamlandChallenge.DreamlandChallengeControl;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class DCDuplicateChooseView extends Sprite implements Disposeable
   {
       
      
      private var _preDupView:DCDuplicateChooseItem;
      
      private var _nextDupView:DCDuplicateChooseItem;
      
      private var _curDupView:DCDuplicateChooseItem;
      
      private var _control:DreamlandChallengeControl;
      
      private var _temView:DCDuplicateChooseItem;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _prePos:Point;
      
      private var _curPos:Point;
      
      private var _nextPos:Point;
      
      public function DCDuplicateChooseView(control:DreamlandChallengeControl)
      {
         _control = control;
         super();
         initView();
         initDuplicateInfo();
      }
      
      private function initView() : void
      {
         _prePos = ComponentFactory.Instance.creat("asset.dreamLand.dupView.prePagepos") as Point;
         _curPos = ComponentFactory.Instance.creat("asset.dreamLand.dupView.curPagepos") as Point;
         _nextPos = ComponentFactory.Instance.creat("asset.dreamLand.dupView.nextPagepos") as Point;
         _preDupView = new DCDuplicateChooseItem(0,_control);
         _preDupView.scale = 0.85;
         _preDupView.setPosition(_prePos.x,_prePos.y);
         addChild(_preDupView);
         _nextDupView = new DCDuplicateChooseItem(1,_control);
         _nextDupView.scale = 0.85;
         _nextDupView.setPosition(_nextPos.x,_nextPos.y);
         addChild(_nextDupView);
         _curDupView = new DCDuplicateChooseItem(2,_control);
         _curDupView.scale = 1;
         _curDupView.setPosition(_curPos.x,_curPos.y);
         addChild(_curDupView);
      }
      
      private function initDuplicateInfo() : void
      {
         var cur:int = ServerConfigManager.instance.DreamLandId;
         _curDupView.info = _control.getDupInfoById(cur);
      }
      
      public function get curSelectedDuplicateInfo() : DungeonInfo
      {
         var info:DungeonInfo = _curDupView.info;
         return info;
      }
      
      public function get curSelectedDupDifficulty() : int
      {
         return _curDupView.curDifficulty;
      }
      
      private function challengeCountBuyAlert() : void
      {
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.dreamLand.challengeCount.buyPrompt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",function():*
         {
            var /*UnknownSlot*/:* = function(evt:FrameEvent):void
            {
               _confirmFrame.removeEventListener("response",__confirmBuy);
               if(evt.responseCode == 3 || evt.responseCode == 2)
               {
                  if(_control)
                  {
                     _control.showBuychallengeCountFrame();
                  }
               }
            };
            return function(evt:FrameEvent):void
            {
               _confirmFrame.removeEventListener("response",__confirmBuy);
               if(evt.responseCode == 3 || evt.responseCode == 2)
               {
                  if(_control)
                  {
                     _control.showBuychallengeCountFrame();
                  }
               }
            };
         }());
      }
      
      private function addEvent() : void
      {
         _preDupView.addEventListener("click",__pageItemClick);
         _nextDupView.addEventListener("click",__pageItemClick);
         _curDupView.addEventListener("click",__pageItemClick);
      }
      
      private function __pageItemClick(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var temItem:DCDuplicateChooseItem = evt.target.parent as DCDuplicateChooseItem;
         if(temItem == null || temItem.type == 2 || !_control.isClick)
         {
            return;
         }
         if(temItem.type == 0)
         {
            moveItemToRigth(temItem);
         }
         else if(temItem.type == 1)
         {
            moveItemToLeft(temItem);
         }
      }
      
      private function moveItemToRigth(item:DCDuplicateChooseItem) : void
      {
         item = item;
         if(item == null || item.type != 0)
         {
            return;
         }
         _temView = _preDupView;
         TweenLite.to(_preDupView,0.5,{
            "x":_curPos.x,
            "y":_curPos.y,
            "scaleX":1,
            "scaleY":1,
            "onComplete":function():*
            {
               var /*UnknownSlot*/:* = function():void
               {
                  _preDupView.type = 2;
               };
               return function():void
               {
                  _preDupView.type = 2;
               };
            }()
         });
         addChildAt(_preDupView,numChildren - 1);
         TweenLite.to(_curDupView,0.5,{
            "x":_nextPos.x,
            "y":_nextPos.y,
            "scaleX":0.85,
            "scaleY":0.85,
            "onComplete":function():*
            {
               var /*UnknownSlot*/:* = function():void
               {
                  _curDupView.type = 1;
               };
               return function():void
               {
                  _curDupView.type = 1;
               };
            }()
         });
         addChildAt(_curDupView,0);
         _nextDupView.setPosition(_prePos.x,_prePos.y);
         TweenLite.from(_nextDupView,0.5,{
            "alpha":0,
            "onComplete":function():*
            {
               var /*UnknownSlot*/:* = function():void
               {
                  _nextDupView.type = 0;
                  _preDupView = _nextDupView;
                  _nextDupView = _curDupView;
                  _curDupView = _temView;
                  resetItem();
               };
               return function():void
               {
                  _nextDupView.type = 0;
                  _preDupView = _nextDupView;
                  _nextDupView = _curDupView;
                  _curDupView = _temView;
                  resetItem();
               };
            }()
         });
         addChildAt(_nextDupView,0);
      }
      
      private function resetItem() : void
      {
         _preDupView.buttonMode = true;
         _nextDupView.buttonMode = true;
         _curDupView.buttonMode = false;
      }
      
      private function moveItemToLeft(item:DCDuplicateChooseItem) : void
      {
         item = item;
         if(item == null || item.type != 1)
         {
            return;
         }
         _temView = _nextDupView;
         TweenLite.to(_nextDupView,0.5,{
            "x":_curPos.x,
            "y":_curPos.y,
            "scaleX":1,
            "scaleY":1,
            "onComplete":function():*
            {
               var /*UnknownSlot*/:* = function():void
               {
                  _nextDupView.type = 2;
               };
               return function():void
               {
                  _nextDupView.type = 2;
               };
            }()
         });
         addChildAt(_nextDupView,numChildren - 1);
         TweenLite.to(_curDupView,0.5,{
            "x":_nextPos.x,
            "y":_nextPos.y,
            "scaleX":0.85,
            "scaleY":0.85,
            "onComplete":function():*
            {
               var /*UnknownSlot*/:* = function():void
               {
                  _curDupView.type = 0;
                  _curDupView.scale = 1;
               };
               return function():void
               {
                  _curDupView.type = 0;
                  _curDupView.scale = 1;
               };
            }()
         });
         addChildAt(_curDupView,0);
         _preDupView.setPosition(_nextPos.x,_nextPos.y);
         TweenLite.from(_preDupView,0.5,{
            "alpha":0,
            "onComplete":function():*
            {
               var /*UnknownSlot*/:* = function():void
               {
                  _preDupView.type = 1;
                  _nextDupView = _preDupView;
                  _preDupView = _curDupView;
                  _curDupView = _temView;
                  resetItem();
               };
               return function():void
               {
                  _preDupView.type = 1;
                  _nextDupView = _preDupView;
                  _preDupView = _curDupView;
                  _curDupView = _temView;
                  resetItem();
               };
            }()
         });
         addChildAt(_preDupView,0);
      }
      
      private function removeEvent() : void
      {
         _preDupView.removeEventListener("click",__pageItemClick);
         _nextDupView.removeEventListener("click",__pageItemClick);
         _curDupView.removeEventListener("click",__pageItemClick);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_preDupView);
         _preDupView = null;
         ObjectUtils.disposeObject(_curDupView);
         _curDupView = null;
         ObjectUtils.disposeObject(_nextDupView);
         _nextDupView = null;
         _temView = null;
      }
   }
}
