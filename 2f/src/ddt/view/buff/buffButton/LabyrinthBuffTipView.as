package ddt.view.buff.buffButton{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.DisplayObjectViewport;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BuffInfo;   import ddt.manager.PlayerManager;   import flash.display.Sprite;   import game.view.propertyWaterBuff.PropertyWaterBuffBar;   import road7th.data.DictionaryData;      public class LabyrinthBuffTipView extends Sprite   {                   private var _viewBg:ScaleBitmapImage;            private var _buffList:DictionaryData;            private var _buffItemVBox:VBox;            private var _scrollPanel:ScrollPanel;            public function LabyrinthBuffTipView() { super(); }
            private function createIconList() : void { }
            private function initView() : void { }
            public function dispose() : void { }
            public function get viewBg() : DisplayObjectViewport { return null; }
            public function get buffItemVBox() : VBox { return null; }
   }}