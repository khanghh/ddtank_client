package ddt.view.buff.buffButton
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.DisplayObjectViewport;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import game.view.propertyWaterBuff.PropertyWaterBuffBar;
   import road7th.data.DictionaryData;
   
   public class LabyrinthBuffTipView extends Sprite
   {
       
      
      private var _viewBg:ScaleBitmapImage;
      
      private var _buffList:DictionaryData;
      
      private var _buffItemVBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function LabyrinthBuffTipView()
      {
         super();
         _buffList = PropertyWaterBuffBar.getPropertyWaterBuffList(PlayerManager.Instance.Self.buffInfo);
         initView();
         createIconList();
      }
      
      private function createIconList() : void
      {
         var item:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _buffList;
         for each(var buffInfo in _buffList)
         {
            item = new LabyrinthBuffItem(buffInfo);
            _buffItemVBox.addChild(item);
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function initView() : void
      {
         _viewBg = ComponentFactory.Instance.creatComponentByStylename("bagBuffer.tipView.bg");
         addChild(_viewBg);
         _viewBg.height = 177;
         _buffItemVBox = ComponentFactory.Instance.creatComponentByStylename("labyrinthBuff.Vbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("labyrinthBuff.scrollPanel");
         _scrollPanel.setView(_buffItemVBox);
         addChild(_scrollPanel);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_buffItemVBox);
         _buffItemVBox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         if(_viewBg)
         {
            _viewBg.dispose();
            _viewBg = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get viewBg() : DisplayObjectViewport
      {
         return _scrollPanel.displayObjectViewport;
      }
      
      public function get buffItemVBox() : VBox
      {
         return _buffItemVBox;
      }
   }
}
