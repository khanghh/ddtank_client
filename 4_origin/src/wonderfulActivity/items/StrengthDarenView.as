package wonderfulActivity.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.views.IRightView;
   
   public class StrengthDarenView extends Sprite implements IRightView
   {
       
      
      private var _back:Bitmap;
      
      private var _activityTimeTxt:FilterFrameText;
      
      private var _activityInfo:GmActivityInfo;
      
      private var _giftInfoDic:Dictionary;
      
      private var _statusArr:Array;
      
      private var _strengthGradeArr:Array;
      
      private var _listStrengthItem:Vector.<StrengthDarenItem>;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function StrengthDarenView()
      {
         super();
      }
      
      public function setState(param1:int, param2:int) : void
      {
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function init() : void
      {
         initView();
         initData();
         initViewWithData();
      }
      
      private function initViewWithData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         if(!_activityInfo)
         {
            return;
         }
         var _loc2_:Array = [_activityInfo.beginTime.split(" ")[0],_activityInfo.endTime.split(" ")[0]];
         _activityTimeTxt.text = _loc2_[0] + "-" + _loc2_[1];
         _loc3_ = 0;
         while(_loc3_ < _activityInfo.giftbagArray.length)
         {
            _loc1_ = new StrengthDarenItem(_loc3_ % 2,_activityInfo.activityId,_activityInfo.giftbagArray[_loc3_],_giftInfoDic[_activityInfo.giftbagArray[_loc3_].giftbagId],_statusArr);
            _listStrengthItem.push(_loc1_);
            _vbox.addChild(_loc1_);
            _loc3_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function initData() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _strengthGradeArr = [];
         _listStrengthItem = new Vector.<StrengthDarenItem>();
         var _loc5_:int = 0;
         var _loc4_:* = WonderfulActivityManager.Instance.activityData;
         for each(var _loc1_ in WonderfulActivityManager.Instance.activityData)
         {
            if(_loc1_.activityType == 8 && _loc1_.activityChildType == 0)
            {
               _activityInfo = _loc1_;
               if(WonderfulActivityManager.Instance.activityInitData[_loc1_.activityId])
               {
                  _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[_loc1_.activityId]["giftInfoDic"];
                  _statusArr = WonderfulActivityManager.Instance.activityInitData[_loc1_.activityId]["statusArr"];
               }
               _loc3_ = 0;
               while(_loc3_ < _loc1_.giftbagArray.length)
               {
                  _loc2_ = 0;
                  while(_loc2_ < _loc1_.giftbagArray[_loc3_].giftConditionArr.length)
                  {
                     if(_loc1_.giftbagArray[_loc3_].giftConditionArr[_loc2_].conditionIndex == 0)
                     {
                        _strengthGradeArr.push(_loc1_.giftbagArray[_loc3_].giftConditionArr[_loc2_].conditionValue);
                     }
                     _loc2_++;
                  }
                  _loc3_++;
               }
               continue;
            }
         }
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("wonderfulactivity.strength.back");
         addChild(_back);
         _activityTimeTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.activetimeTxt");
         addChild(_activityTimeTxt);
         PositionUtils.setPos(_activityTimeTxt,"wonderful.strengthdaren.activetime.pos");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.left.vBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.scrollpanel");
         _vbox.spacing = 3;
         PositionUtils.setPos(_scrollPanel,"wonderful.scrollPanel.pos");
         _scrollPanel.height = 285;
         _scrollPanel.setView(_vbox);
         _scrollPanel.invalidateViewport();
         addChild(_scrollPanel);
      }
      
      public function setData(param1:* = null) : void
      {
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _listStrengthItem.length)
         {
            ObjectUtils.disposeObject(_listStrengthItem[_loc1_]);
            _listStrengthItem[_loc1_] = null;
            _loc1_++;
         }
         _listStrengthItem = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
            _vbox = null;
         }
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_activityTimeTxt);
         _activityTimeTxt = null;
         if(parent)
         {
            ObjectUtils.disposeObject(this);
         }
      }
   }
}
