package godCardRaise.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardPointRewardListInfo;
   
   public class GodCardRaiseScoreViewItem extends Sprite implements Disposeable
   {
       
      
      private var _info:GodCardPointRewardListInfo;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _awardCell:BagCell;
      
      private var _getBtn:BaseButton;
      
      private var _getBmp:Bitmap;
      
      private var _clickNum:Number = 0;
      
      public function GodCardRaiseScoreViewItem(param1:GodCardPointRewardListInfo){super();}
      
      private function initView() : void{}
      
      public function updateView() : void{}
      
      private function __getBtnHandler(param1:MouseEvent) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
