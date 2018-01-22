package store.view.strength
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class SpellAlertFrame extends BaseAlerFrame implements Disposeable
   {
      
      public static const CLOSE:String = "close";
      
      public static const SUBMIT:String = "submit";
       
      
      private var _cell:BagCell;
      
      private var _alertText:FilterFrameText;
      
      private var _alertInfo:AlertInfo;
      
      public function SpellAlertFrame()
      {
         super();
         initContainer();
      }
      
      private function initContainer() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("AlertDialog.Info");
         _alertInfo.enterEnable = true;
         _alertInfo.escEnable = true;
         info = _alertInfo;
         _alertText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.view.strength.alertText");
         _alertText.text = LanguageMgr.GetTranslation("store.view.strength.noneSymble");
         addToContent(_alertText);
         _cell = CellFactory.instance.createPersonalInfoCell(-1,ItemManager.Instance.getTemplateById(11020),true) as BagCell;
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("ddtstore.view.strength.cellPos");
         _cell.x = _loc1_.x;
         _cell.y = _loc1_.y;
         _cell.setContentSize(60,60);
         addToContent(_cell);
         addEventListener("response",__frameEvent);
      }
      
      private function __frameEvent(param1:FrameEvent) : void
      {
         dispose();
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispatchEvent(new Event("close"));
               SoundManager.instance.play("008");
               break;
            case 2:
            case 3:
            case 4:
               SoundManager.instance.play("008");
               dispatchEvent(new Event("submit"));
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,false,2);
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__frameEvent);
         if(_alertText)
         {
            _alertText.dispose();
         }
         _alertText = null;
         if(_cell)
         {
            _cell.dispose();
         }
         _cell = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
