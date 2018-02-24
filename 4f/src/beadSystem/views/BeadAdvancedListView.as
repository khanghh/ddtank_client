package beadSystem.views
{
   import beadSystem.model.AdvanceBeadInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class BeadAdvancedListView extends Sprite implements Disposeable
   {
      
      public static const BEAD_SELECT_CHANGE:String = "beadSelectChange";
       
      
      private var _infos:DictionaryData;
      
      private var _panel:ScrollPanel;
      
      private var _beadItemContainerAll:VBox;
      
      private var _itemArray:Array;
      
      public function BeadAdvancedListView(){super();}
      
      protected function initView() : void{}
      
      public function set beadInfos(param1:DictionaryData) : void{}
      
      private function itemClickHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
