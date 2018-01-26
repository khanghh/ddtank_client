package hall.tasktrack
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import quest.QuestDescTextAnalyz;
   import quest.QuestRewardCell;
   
   public class HallTaskManuGetView extends Sprite implements Disposeable
   {
       
      
      private var _info:QuestInfo;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _getBtn:SimpleBitmapButton;
      
      public function HallTaskManuGetView(param1:QuestInfo){super();}
      
      private function initView() : void{}
      
      private function checkDescTxt(param1:FilterFrameText) : void{}
      
      private function initAwardNum() : void{}
      
      private function initAwardItem() : void{}
      
      private function initEvent() : void{}
      
      private function questManuGetHandler(param1:PkgEvent) : void{}
      
      private function closeClickHandler(param1:MouseEvent) : void{}
      
      private function getClickHandler(param1:MouseEvent) : void{}
      
      private function getSexByInt(param1:Boolean) : int{return 0;}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
