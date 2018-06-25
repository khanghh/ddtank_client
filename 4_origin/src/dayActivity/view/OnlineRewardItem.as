package dayActivity.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.DayActivityManager;
   import dayActivity.OnlineRewardModel;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class OnlineRewardItem extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _icon:Bitmap;
      
      private var _valueTf:FilterFrameText;
      
      private var _nameTf:FilterFrameText;
      
      private var _getFlag:Bitmap;
      
      private var _model:OnlineRewardModel;
      
      public function OnlineRewardItem(index:int)
      {
         super();
         _index = index;
         _model = DayActivityManager.Instance.onlineRewardModel;
         initView();
      }
      
      private function initView() : void
      {
         _icon = UICreatShortcut.creatAndAdd("day.activity.onlineReward.icon" + (_index + 1),this);
         _valueTf = UICreatShortcut.creatTextAndAdd("day.activity.onlineReward.valueTf",LanguageMgr.GetTranslation("ddt.Dayactivity.onlineReward.valueQuan",_model.boxConfigArr[_index]["worthMoney"]),this);
         _nameTf = UICreatShortcut.creatAndAdd("day.activity.onlineReward.nameTf",this);
         _getFlag = UICreatShortcut.creatAndAdd("day.activity.onlineReward.getFlag",this);
         _getFlag.visible = false;
      }
      
      public function update() : void
      {
         var boxConfig:Object = _model.boxConfigArr[_index];
         if(boxConfig["boxId"] <= _model.hasGetBoxId)
         {
            _nameTf.text = boxConfig["boxName"];
            _nameTf.textFormatStyle = "day.activity.onlineReward.nameTf.format1";
            _getFlag.visible = true;
         }
         else if(boxConfig["sec"] < _model.onlineSec)
         {
            _nameTf.text = LanguageMgr.GetTranslation("ddt.Dayactivity.onlineReward.canGet");
            _nameTf.textFormatStyle = "day.activity.onlineReward.nameTf.format2";
            _getFlag.visible = false;
         }
         else
         {
            _nameTf.text = LanguageMgr.GetTranslation("ddt.Dayactivity.onlineReward.getCon",int(boxConfig["sec"] / 60));
            _nameTf.textFormatStyle = "day.activity.onlineReward.nameTf.format3";
            _getFlag.visible = false;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _icon = null;
         _valueTf = null;
         _nameTf = null;
         _getFlag = null;
         _model = null;
      }
   }
}
