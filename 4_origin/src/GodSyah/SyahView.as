package GodSyah
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import wonderfulActivity.views.IRightView;
   
   public class SyahView extends Sprite implements IRightView
   {
       
      
      private var _bg:Bitmap;
      
      private var _valid:FilterFrameText;
      
      private var _description:FilterFrameText;
      
      private var _content:SyahItemContent;
      
      private var _vbox:VBox;
      
      private var _scrollpanel:ScrollPanel;
      
      public function SyahView()
      {
         super();
         SyahManager.Instance.selectFromBagAndInfo();
         SyahManager.Instance.inView = true;
         _buildUI();
      }
      
      private function _buildUI() : void
      {
         _bg = ComponentFactory.Instance.creat("wonderfulactivity.GodSyah.syahView.bg");
         _valid = ComponentFactory.Instance.creatComponentByStylename("wonderful.Activity.Syahview.validTxt");
         _description = ComponentFactory.Instance.creatComponentByStylename("wonderful.Activity.Syahview.descriptionTxt");
         _valid.text = SyahManager.Instance.valid;
         _description.text = "        " + SyahManager.Instance.description;
         _content = ComponentFactory.Instance.creatCustomObject("godsyah.syahview.syahitemcontent");
         addChild(_bg);
         addChild(_valid);
         addChild(_description);
         _createItem();
         addChild(_content);
      }
      
      private function _createItem() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _vbox = ComponentFactory.Instance.creatComponentByStylename("godsyah.syahview.syahitemVbox");
         var _loc1_:Vector.<InventoryItemInfo> = SyahManager.Instance.cellItems;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("godsyah.syahview.syahitem");
            _loc2_.setSyahItemInfo(_loc1_[_loc3_]);
            _vbox.addChild(_loc2_);
            _loc3_++;
         }
         _scrollpanel = ComponentFactory.Instance.creatComponentByStylename("godsyah.syahview.syahitemList");
         _scrollpanel.setView(_vbox);
         _scrollpanel.invalidateViewport();
         addChild(_scrollpanel);
      }
      
      public function init() : void
      {
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function setState(param1:int, param2:int) : void
      {
      }
      
      public function dispose() : void
      {
         SyahManager.Instance.inView = false;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_valid)
         {
            ObjectUtils.disposeObject(_valid);
            _valid = null;
         }
         if(_description)
         {
            ObjectUtils.disposeObject(_description);
            _description = null;
         }
         if(_content)
         {
            _content.dispose();
            _content = null;
         }
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
            _vbox = null;
         }
         if(_scrollpanel)
         {
            ObjectUtils.disposeObject(_scrollpanel);
            _scrollpanel = null;
         }
      }
   }
}
