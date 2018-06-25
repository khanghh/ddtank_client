package ddt.view.common.church
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class ChurchDialogueRejectPropose extends BaseAlerFrame
   {
       
      
      private var _contentTxt:FilterFrameText;
      
      private var _cell:BagCell;
      
      private var _alertInfo:AlertInfo;
      
      private var _name_txt:FilterFrameText;
      
      private var _cellPoint:Rectangle;
      
      private var _msgInfo:String;
      
      public function ChurchDialogueRejectPropose()
      {
         super();
         initialize();
      }
      
      public function get msgInfo() : String
      {
         return _msgInfo;
      }
      
      public function set msgInfo(value:String) : void
      {
         _msgInfo = value;
         _contentTxt.text = LanguageMgr.GetTranslation("common.church.ChurchDialogueRejectPropose.contentText.text",_msgInfo);
      }
      
      private function initialize() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.title = "Gợi ý";
         _alertInfo.showCancel = false;
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _contentTxt = ComponentFactory.Instance.creat("common.church.ChurchDialogueRejectPropose.contentText");
         _contentTxt.text = LanguageMgr.GetTranslation("common.church.ChurchDialogueRejectPropose.contentText.text");
         addToContent(_contentTxt);
         _name_txt = ComponentFactory.Instance.creat("common.church.churchDialogueRejectProposeUserNameAsset");
         _cellPoint = ComponentFactory.Instance.creat("common.church.churchDialogueRejectProposeUserNamePoint");
         _cell = CellFactory.instance.createPersonalInfoCell(-1,ItemManager.Instance.getTemplateById(1120255),true) as BagCell;
         _cell.setContentSize(_cellPoint.width,_cellPoint.height);
         _cell.x = _cellPoint.x;
         _cell.y = _cellPoint.y;
         addToContent(_cell);
         addEventListener("response",onFrameResponse);
      }
      
      private function onFrameResponse(evt:FrameEvent) : void
      {
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
               SoundManager.instance.play("008");
               confirmSubmit();
         }
      }
      
      private function confirmSubmit() : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      public function show() : void
      {
         SoundManager.instance.play("018");
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("response",onFrameResponse);
         _alertInfo = null;
         _cellPoint = null;
         _cell = null;
         if(_contentTxt)
         {
            ObjectUtils.disposeObject(_contentTxt);
         }
         _contentTxt = null;
         ObjectUtils.disposeObject(_name_txt);
         _name_txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
   }
}
