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
         var blessCountPic:Bitmap = ComponentFactory.Instance.creatBitmap("asset.witchBlessing.blessCount");
         _numberSelecter = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.NumberSelecter");
         PositionUtils.setPos(_numberSelecter,"witchBlessing.expCountSelecterPos");
         _numberSelecter.addEventListener("change",__seleterChange);
         _needText = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.NeedText");
         _needText.visible = false;
         addToContent(blessCountPic);
         addToContent(_numberSelecter);
         addToContent(_needText);
      }
      
      public function show(needCount:int, needExp:int, max:int, allNeedMax:int) : void
      {
         if(max > allNeedMax)
         {
            _numberSelecter.valueLimit = "1," + allNeedMax;
         }
         else
         {
            _numberSelecter.valueLimit = "1," + max;
         }
         LayerManager.Instance.addToLayer(this,2,true,1);
         _numberSelecter.currentValue = 1;
         if(isDoubleTime(ServerConfigManager.instance.getWitchBlessDoubleGpTime))
         {
            _needText.htmlText = LanguageMgr.GetTranslation("witchBlessing.View.NeedExpText",ServerConfigManager.instance.getWitchBlessMoney,int(ServerConfigManager.instance.getWitchBlessGP[2]) * 2,needExp);
         }
         else
         {
            _needText.htmlText = LanguageMgr.GetTranslation("witchBlessing.View.NeedExpText",ServerConfigManager.instance.getWitchBlessMoney,ServerConfigManager.instance.getWitchBlessGP[2],needExp);
         }
         _needText.visible = true;
      }
      
      private function isDoubleTime(doubleTime:String) : Boolean
      {
         var _dTime:Array = doubleTime.split("-");
         var starTime:Array = _dTime[0].toString().split(":");
         var endTime:Array = _dTime[1].toString().split(":");
         var date:Date = TimeManager.Instance.Now();
         var flag:Boolean = false;
         var startDate:Date = TimeManager.Instance.Now();
         startDate.setDate(date.date);
         startDate.setHours(int(starTime[0]),int(starTime[1]),0);
         var endDate:Date = new Date();
         endDate.setDate(date.date);
         endDate.setHours(int(endTime[0]),int(endTime[1]),0);
         if(date.getTime() >= startDate.getTime() && date.getTime() <= endDate.getTime())
         {
            flag = true;
         }
         return flag;
      }
      
      private function __seleterChange(event:Event) : void
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
