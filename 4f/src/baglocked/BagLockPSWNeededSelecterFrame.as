package baglocked
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class BagLockPSWNeededSelecterFrame extends Frame implements Disposeable
   {
       
      
      private var _detailText:MovieClip;
      
      private var _selecterScrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _submitBtn:TextButton;
      
      private var _needPSWCellList:Vector.<BagLockPSWNeededSelecterListCell>;
      
      private var _bg:Scale9CornerImage;
      
      private var _btnBG:ScaleBitmapImage;
      
      public function BagLockPSWNeededSelecterFrame(){super();}
      
      override protected function init() : void{}
      
      public function initList() : void{}
      
      public function refresh() : void{}
      
      protected function onSubmit(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
