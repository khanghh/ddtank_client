package tryonSystem
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import equipretrieve.effect.AnimationControl;
   import equipretrieve.effect.GlowFilterAnimation;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import quest.QuestRewardCell;
   
   public class ChooseFrame extends BaseAlerFrame
   {
       
      
      private var _control:TryonSystemController;
      
      private var _bg:ScaleBitmapImage;
      
      private var _cells:Array;
      
      private var _list:SimpleTileList;
      
      private var _panel:ScrollPanel;
      
      public function ChooseFrame(){super();}
      
      public function set controller(param1:TryonSystemController) : void{}
      
      private function initView() : void{}
      
      private function _cellLightComplete(param1:Event) : void{}
      
      private function __onclick(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
