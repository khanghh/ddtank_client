package explorerManual.view.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.utils.PositionUtils;
   import explorerManual.ExplorerManualManager;
   import explorerManual.data.ExplorerManualInfo;
   import explorerManual.data.model.ManualPageItemInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class ExplorerPageDirectorItemView extends Sprite implements Disposeable
   {
      
      public static const ITEM_CLICK:String = "directorItemClick";
      
      private static const OMIT_STR:String = "....................................................................";
       
      
      private var _totalLen:int = 90;
      
      private var _itemTxt:FilterFrameText;
      
      private var _processText:FilterFrameText;
      
      private var _index:int;
      
      private var _info:ManualPageItemInfo;
      
      private var _model:ExplorerManualInfo;
      
      private var _icon:MovieClip;
      
      private var _selectedBg:Bitmap;
      
      public function ExplorerPageDirectorItemView(param1:int, param2:ExplorerManualInfo)
      {
         super();
         _index = param1;
         _model = param2;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _selectedBg = ComponentFactory.Instance.creat("asset.explorerManual.dicSelectedItem.bg");
         addChild(_selectedBg);
         PositionUtils.setPos(_selectedBg,"explorerManual.directorItem.selectedBgPos");
         _selectedBg.visible = false;
         _itemTxt = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageDirectoryView.itemTxt");
         addChild(_itemTxt);
         _icon = ComponentFactory.Instance.creat("asset.explorerManual.sighIcon");
         PositionUtils.setPos(_icon,"explorerManual.directorItem.sighIconPos");
         _icon.visible = false;
         addChild(_icon);
         _processText = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageDirectoryView.itemProgressTxt");
         addChild(_processText);
      }
      
      private function initEvent() : void
      {
         if(_itemTxt)
         {
            _itemTxt.addEventListener("link",itemLinkClick_Handler);
         }
         this.addEventListener("mouseOver",__mouseOverHandler);
         this.addEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         if(_itemTxt)
         {
            _itemTxt.removeEventListener("link",itemLinkClick_Handler);
         }
         this.removeEventListener("mouseOut",__mouseOutHandler);
         this.removeEventListener("mouseOver",__mouseOverHandler);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         _selectedBg.visible = true;
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _selectedBg.visible = false;
      }
      
      private function itemLinkClick_Handler(param1:TextEvent) : void
      {
         if(_info && _icon.visible)
         {
            ExplorerManualManager.instance.removeNewDebrisForPages(_info.ID);
            _icon.visible = false;
         }
         this.dispatchEvent(new CEvent("directorItemClick",param1.text));
      }
      
      public function set info(param1:ManualPageItemInfo) : void
      {
         _info = param1;
         if(_info == null)
         {
            return;
         }
         createItem();
         showSighIcon();
      }
      
      private function showSighIcon() : void
      {
         if(_icon == null || _info == null)
         {
            return;
         }
         _icon.visible = ExplorerManualManager.instance.isHaveNewDebrisForPage(_info.ID);
      }
      
      private function createItem() : void
      {
         var _loc4_:* = null;
         var _loc1_:String = _info.Name;
         _loc4_ = _loc1_ + "....................................................................";
         var _loc3_:int = _model.debrisInfo.getHaveDebrisByPageID(_info.ID).length;
         var _loc2_:int = _info.DebrisCount;
         _processText.text = _index + " ( " + _loc3_ + "/" + _loc2_ + " )";
         _itemTxt.htmlText = "<a href=\'event:" + _info.Sort + "\'>" + _loc4_ + "</a>";
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemTxt);
         _itemTxt = null;
         ObjectUtils.disposeObject(_selectedBg);
         _selectedBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_processText);
         _processText = null;
         _info = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
