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
      
      public function SpellAlertFrame(){super();}
      
      private function initContainer() : void{}
      
      private function __frameEvent(param1:FrameEvent) : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
   }
}
