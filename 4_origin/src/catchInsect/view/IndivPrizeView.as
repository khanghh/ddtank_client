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
      
      public function IndivPrizeView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         _bg = ComponentFactory.Instance.creat("catchInsect.indivPrizeBg");
         addChild(_bg);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("catchInsect.indivPrize.vBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("catchInsect.indivPrize.scrollpanel");
         _scrollPanel.setView(_vbox);
         addChild(_scrollPanel);
         _listItem = new Vector.<IndivPrizeCell>();
         var _loc2_:Array = ServerConfigManager.instance.catchInsectPrizeInfo;
         _loc4_ = 0;
         while(_loc4_ <= _loc2_.length - 1)
         {
            _loc1_ = _loc2_[_loc4_].split(",");
            _loc3_ = new IndivPrizeCell();
            _loc3_.setData(_loc1_[0],_loc1_[1]);
            _vbox.addChild(_loc3_);
            _listItem.push(_loc3_);
            _loc4_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function initEvents() : void
      {
      }
      
      public function setPrizeStatus(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ <= _listItem.length - 1)
         {
            _listItem[_loc2_].setStatus(param1 & 1);
            param1 = param1 >> 1;
            _loc2_++;
         }
      }
      
      private function removeEvents() : void
      {
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvents();
         _loc1_ = 0;
         while(_loc1_ <= _listItem.length - 1)
         {
            ObjectUtils.disposeObject(_listItem[_loc1_]);
            _listItem[_loc1_] = null;
            _loc1_++;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
      }
   }
}
