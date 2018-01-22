package catchInsect.view
{
   import catchInsect.componets.IndivPrizeCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ServerConfigManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class IndivPrizeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _listItem:Vector.<IndivPrizeCell>;
      
      public function IndivPrizeView(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      public function setPrizeStatus(param1:int) : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
