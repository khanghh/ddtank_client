package witchBlessing.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class WitchBlessingFrame extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _text:FilterFrameText;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _needText:FilterFrameText;
      
      public function WitchBlessingFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("witchBlessing.view.doubleBlessTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.witchBlessing.blessCount");
         _numberSelecter = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.NumberSelecter");
         PositionUtils.setPos(_numberSelecter,"witchBlessing.expCountSelecterPos");
         _numberSelecter.addEventListener("change",__seleterChange);
         _needText = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.NeedText");
         _needText.visible = false;
         addToContent(_loc1_);
         addToContent(_numberSelecter);
         addToContent(_needText);
      }
      
      public function show(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(param3 > param4)
         {
            _numberSelecter.valueLimit = "1," + param4;
         }
         else
         {
            _numberSelecter.valueLimit = "1," + param3;
         }
         LayerManager.Instance.addToLayer(this,2,true,1);
         _numberSelecter.currentValue = 1;
         if(isDoubleTime(ServerConfigManager.instance.getWitchBlessDoubleGpTime))
         {
            _needText.htmlText = LanguageMgr.GetTranslation("witchBlessing.View.NeedExpText",ServerConfigManager.instance.getWitchBlessMoney,int(ServerConfigManager.instance.getWitchBlessGP[2]) * 2,param2);
         }
         else
         {
            _needText.htmlText = LanguageMgr.GetTranslation("witchBlessing.View.NeedExpText",ServerConfigManager.instance.getWitchBlessMoney,ServerConfigManager.instance.getWitchBlessGP[2],param2);
         }
         _needText.visible = true;
      }
      
      private function isDoubleTime(param1:String) : Boolean
      {
         var _loc2_:Array = param1.split("-");
         var _loc5_:Array = _loc2_[0].toString().split(":");
         var _loc8_:Array = _loc2_[1].toString().split(":");
         var _loc7_:Date = TimeManager.Instance.Now();
         var _loc4_:Boolean = false;
         var _loc3_:Date = TimeManager.Instance.Now();
         _loc3_.setDate(_loc7_.date);
         _loc3_.setHours(int(_loc5_[0]),int(_loc5_[1]),0);
         var _loc6_:Date = new Date();
         _loc6_.setDate(_loc7_.date);
         _loc6_.setHours(int(_loc8_[0]),int(_loc8_[1]),0);
         if(_loc7_.getTime() >= _loc3_.getTime() && _loc7_.getTime() <= _loc6_.getTime())
         {
            _loc4_ = true;
         }
         return _loc4_;
      }
      
      private function __seleterChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function get count() : int
      {
         return _numberSelecter.currentValue;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_numberSelecter)
         {
            _numberSelecter.removeEventListener("change",__seleterChange);
         }
         removeView();
      }
      
      private function removeView() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_numberSelecter);
         _numberSelecter = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_needText);
         _needText = null;
      }
   }
}
