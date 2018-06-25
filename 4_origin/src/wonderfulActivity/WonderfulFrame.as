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
      
      public function setState(type:int, id:int) : void
      {
         if(!_rightView && !_rightView.parent)
         {
            return;
         }
         _rightView.setState(type,id);
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
      
      public function addElement(actArr:Array) : void
      {
         var infoDic:* = null;
         var vo:* = null;
         var wonderArr:Array = [];
         var limitArr:Array = [];
         var newServerArr:Array = [];
         if(WonderfulActivityManager.Instance.isExchangeAct)
         {
            infoDic = WonderfulActivityManager.Instance.exchangeActLeftViewInfoDic;
         }
         else
         {
            infoDic = WonderfulActivityManager.Instance.leftViewInfoDic;
         }
         var _loc11_:int = 0;
         var _loc10_:* = actArr;
         for each(var id in actArr)
         {
            if(infoDic[id] != null)
            {
               vo = new ActivityCellVo();
               vo.id = id;
               vo.activityName = infoDic[id].label;
               vo.viewType = infoDic[id].viewType;
               var _loc9_:* = infoDic[id].unitIndex;
               if(1 !== _loc9_)
               {
                  if(3 === _loc9_)
                  {
                     newServerArr.push(vo);
                  }
               }
               else
               {
                  limitArr.push(vo);
               }
            }
         }
         if(newServerArr.length == 0)
         {
            _leftView.isNewServerExist = false;
         }
         else
         {
            _leftView.isNewServerExist = true;
         }
         if(_leftView.isNewServerExist)
         {
            newServerArr.sortOn("viewType",16);
            _leftView.addUnitByType(newServerArr,3);
         }
         else
         {
            _leftView.checkNewServerExist();
         }
         var isExchangeAct:Boolean = WonderfulActivityManager.Instance.isExchangeAct;
         if(isExchangeAct)
         {
            _leftView.addUnitByType(limitArr.concat(wonderArr),4);
         }
         else
         {
            _leftView.addUnitByType(limitArr,1);
         }
         _leftView.extendUnitView();
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(!WonderfulActivityManager.Instance.isRuning)
         {
            return;
         }
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
