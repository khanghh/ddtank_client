package godCardRaise.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.events.Event;
   import godCardRaise.info.GodCardListInfo;
   
   public class GodCardRaiseAtlasCardAlert extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _contentTxt:FilterFrameText;
      
      private var _useClipCountTxt:FilterFrameText;
      
      private var _type:int;
      
      private var _godCardListInfo:GodCardListInfo;
      
      public function GodCardRaiseAtlasCardAlert()
      {
         super();
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("AlertDialog.Info");
         _alertInfo.submitLabel = LanguageMgr.GetTranslation("ok");
         _alertInfo.cancelLabel = LanguageMgr.GetTranslation("cancel");
         _alertInfo.moveEnable = false;
         _alertInfo.enterEnable = false;
         info = _alertInfo;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _numberSelecter = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasCard.NumberSelecter");
         addToContent(_numberSelecter);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasCard.contentTxt");
         addToContent(_contentTxt);
         _useClipCountTxt = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasCard.useClipCountTxt");
         addToContent(_useClipCountTxt);
      }
      
      private function initEvent() : void
      {
         _numberSelecter.addEventListener("change",__numberSelecterHandler);
      }
      
      private function __numberSelecterHandler(event:Event) : void
      {
         if(_type == 1)
         {
            _useClipCountTxt.text = LanguageMgr.GetTranslation("godCardRaiseAtlasCard.smashMsg3",_numberSelecter.currentValue,int(_numberSelecter.currentValue * _godCardListInfo.Decompose));
         }
         else
         {
            _useClipCountTxt.text = LanguageMgr.GetTranslation("godCardRaiseAtlasCard.compositeMsg3",_numberSelecter.currentValue,int(_numberSelecter.currentValue * _godCardListInfo.Composition));
         }
      }
      
      public function set setType($type:int) : void
      {
         _type = $type;
         if(_type == 1)
         {
            _contentTxt.text = LanguageMgr.GetTranslation("godCardRaiseAtlasCard.smashMsg1");
            _useClipCountTxt.text = LanguageMgr.GetTranslation("godCardRaiseAtlasCard.smashMsg3",1,_godCardListInfo.Decompose);
         }
         else
         {
            _contentTxt.text = LanguageMgr.GetTranslation("godCardRaiseAtlasCard.compositeMsg1");
            _useClipCountTxt.text = LanguageMgr.GetTranslation("godCardRaiseAtlasCard.compositeMsg3",1,_godCardListInfo.Composition);
         }
      }
      
      public function set setInfo($info:GodCardListInfo) : void
      {
         _godCardListInfo = $info;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,1);
      }
      
      public function get count() : Number
      {
         return _numberSelecter.currentValue;
      }
      
      public function set valueLimit(value:String) : void
      {
         _numberSelecter.valueLimit = value;
      }
      
      private function removeEvent() : void
      {
         _numberSelecter.removeEventListener("change",__numberSelecterHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_numberSelecter);
         ObjectUtils.disposeObject(_contentTxt);
         ObjectUtils.disposeObject(_useClipCountTxt);
         _numberSelecter = null;
         _contentTxt = null;
         _useClipCountTxt = null;
         _godCardListInfo = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
