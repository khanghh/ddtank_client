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
      
      public function setState(type:int, id:int) : void
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
         var i:int = 0;
         var item:* = null;
         if(!_activityInfo)
         {
            return;
         }
         var timeArr:Array = [_activityInfo.beginTime.split(" ")[0],_activityInfo.endTime.split(" ")[0]];
         _activityTimeTxt.text = timeArr[0] + "-" + timeArr[1];
         for(i = 0; i < _activityInfo.giftbagArray.length; )
         {
            item = new StrengthDarenItem(i % 2,_activityInfo.activityId,_activityInfo.giftbagArray[i],_giftInfoDic[_activityInfo.giftbagArray[i].giftbagId],_statusArr);
            _listStrengthItem.push(item);
            _vbox.addChild(item);
            i++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function initData() : void
      {
         var i:int = 0;
         var j:int = 0;
         _strengthGradeArr = [];
         _listStrengthItem = new Vector.<StrengthDarenItem>();
         var _loc5_:int = 0;
         var _loc4_:* = WonderfulActivityManager.Instance.activityData;
         for each(var item in WonderfulActivityManager.Instance.activityData)
         {
            if(item.activityType == 8 && item.activityChildType == 0)
            {
               _activityInfo = item;
               if(WonderfulActivityManager.Instance.activityInitData[item.activityId])
               {
                  _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[item.activityId]["giftInfoDic"];
                  _statusArr = WonderfulActivityManager.Instance.activityInitData[item.activityId]["statusArr"];
               }
               i = 0;
               while(i < item.giftbagArray.length)
               {
                  for(j = 0; j < item.giftbagArray[i].giftConditionArr.length; )
                  {
                     if(item.giftbagArray[i].giftConditionArr[j].conditionIndex == 0)
                     {
                        _strengthGradeArr.push(item.giftbagArray[i].giftConditionArr[j].conditionValue);
                     }
                     j++;
                  }
                  i++;
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
      
      public function setData(val:* = null) : void
      {
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         for(i = 0; i < _listStrengthItem.length; )
         {
            ObjectUtils.disposeObject(_listStrengthItem[i]);
            _listStrengthItem[i] = null;
            i++;
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
