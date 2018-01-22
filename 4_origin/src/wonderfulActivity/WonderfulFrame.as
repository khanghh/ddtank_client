package wonderfulActivity
{
   import calendar.CalendarControl;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import flash.utils.Dictionary;
   import mysteriousRoullete.MysteriousManager;
   import treasureHunting.TreasureControl;
   import treasureHunting.TreasureManager;
   import wonderfulActivity.data.ActivityCellVo;
   import wonderfulActivity.views.ActivityLeftView;
   import wonderfulActivity.views.WonderfulRightView;
   
   public class WonderfulFrame extends Frame
   {
       
      
      private var _bag:ScaleBitmapImage;
      
      private var _leftView:ActivityLeftView;
      
      private var _rightView:WonderfulRightView;
      
      private var allMusic:Boolean;
      
      public function WonderfulFrame()
      {
         super();
         escEnable = true;
         allMusic = SharedManager.Instance.allowMusic;
         SharedManager.Instance.allowMusic = false;
         SharedManager.Instance.changed();
         initview();
         addEvents();
      }
      
      public function setState(param1:int, param2:int) : void
      {
         if(!_rightView && !_rightView.parent)
         {
            return;
         }
         _rightView.setState(param1,param2);
      }
      
      private function initview() : void
      {
         titleText = LanguageMgr.GetTranslation("wonderfulActivityManager.tittle");
         _bag = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.scale9cornerImageTree");
         addToContent(_bag);
         _leftView = new ActivityLeftView();
         _leftView.x = 22;
         _leftView.y = 46;
         addToContent(_leftView);
         _rightView = new WonderfulRightView();
         addToContent(_rightView);
         _leftView.setRightView(_rightView.updateView);
      }
      
      private function addEvents() : void
      {
         addEventListener("response",_response);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
      }
      
      public function addElement(param1:Array) : void
      {
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc5_:Array = [];
         var _loc7_:Array = [];
         var _loc3_:Array = [];
         if(WonderfulActivityManager.Instance.isExchangeAct)
         {
            _loc4_ = WonderfulActivityManager.Instance.exchangeActLeftViewInfoDic;
         }
         else
         {
            _loc4_ = WonderfulActivityManager.Instance.leftViewInfoDic;
         }
         var _loc11_:int = 0;
         var _loc10_:* = param1;
         for each(var _loc2_ in param1)
         {
            if(_loc4_[_loc2_] != null)
            {
               _loc8_ = new ActivityCellVo();
               _loc8_.id = _loc2_;
               _loc8_.activityName = _loc4_[_loc2_].label;
               _loc8_.viewType = _loc4_[_loc2_].viewType;
               var _loc9_:* = _loc4_[_loc2_].unitIndex;
               if(1 !== _loc9_)
               {
                  if(3 === _loc9_)
                  {
                     _loc3_.push(_loc8_);
                  }
               }
               else
               {
                  _loc7_.push(_loc8_);
               }
            }
         }
         if(_loc3_.length == 0)
         {
            _leftView.isNewServerExist = false;
         }
         else
         {
            _leftView.isNewServerExist = true;
         }
         if(_leftView.isNewServerExist)
         {
            _loc3_.sortOn("viewType",16);
            _leftView.addUnitByType(_loc3_,3);
         }
         else
         {
            _leftView.checkNewServerExist();
         }
         var _loc6_:Boolean = WonderfulActivityManager.Instance.isExchangeAct;
         if(_loc6_)
         {
            _leftView.addUnitByType(_loc7_.concat(_loc5_),4);
         }
         else
         {
            _leftView.addUnitByType(_loc7_,1);
         }
         _leftView.extendUnitView();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(!WonderfulActivityManager.Instance.isRuning)
         {
            return;
         }
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            if(WonderfulActivityManager.Instance.frameCanClose)
            {
               SoundManager.instance.play("008");
               WonderfulActivityManager.Instance.refreshIconStatus();
               clear();
            }
         }
      }
      
      private function clear() : void
      {
         if(TreasureManager.instance.isActivityOpen == false)
         {
            WonderfulActivityManager.Instance.removeElement(11);
         }
         TreasureControl.instance.dispose();
         if(MysteriousManager.instance.isMysteriousClose)
         {
            WonderfulActivityManager.Instance.removeElement(13);
         }
         dispose();
         WonderfulActivityManager.Instance.dispose();
         WonderfulActivityControl.Instance.dispose();
      }
      
      override public function dispose() : void
      {
         WonderfulActivityManager.Instance.isExchangeAct = false;
         if(!WonderfulActivityManager.Instance.isRuning)
         {
            return;
         }
         CalendarControl.getInstance().close();
         SharedManager.Instance.allowMusic = allMusic;
         SharedManager.Instance.changed();
         removeEvents();
         ObjectUtils.disposeObject(_leftView);
         ObjectUtils.disposeObject(_rightView);
         _leftView = null;
         _rightView = null;
         super.dispose();
      }
   }
}
