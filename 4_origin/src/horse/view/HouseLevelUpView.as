package horse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import trainer.view.NewHandContainer;
   
   public class HouseLevelUpView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _leftTopView:HorseFrameLeftTopView;
      
      private var _rightTopView:HorseFrameRightTopView;
      
      private var _leftBottomView:HorseFrameLeftBottomView;
      
      private var _rightBottomView:HorseFrameRightBottomView;
      
      public function HouseLevelUpView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.horse.frame.bg");
         _leftTopView = new HorseFrameLeftTopView();
         _rightTopView = new HorseFrameRightTopView();
         _leftBottomView = new HorseFrameLeftBottomView();
         PositionUtils.setPos(_leftBottomView,"horse.horseFrameLeftBottomViewPos");
         _rightBottomView = new HorseFrameRightBottomView();
         PositionUtils.setPos(_rightBottomView,"horse.horseFrameRightBottomViewPos");
         addChild(_bg);
         addChild(_leftTopView);
         addChild(_rightTopView);
         addChild(_leftBottomView);
         addChild(_rightBottomView);
      }
      
      public function resetSecondPro() : void
      {
         _rightTopView.updateSelfTips();
      }
      
      public function dispose() : void
      {
         NewHandContainer.Instance.clearArrowByID(100000);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_leftTopView);
         _leftTopView = null;
         ObjectUtils.disposeObject(_rightTopView);
         _rightTopView = null;
         ObjectUtils.disposeObject(_leftBottomView);
         _leftBottomView = null;
         ObjectUtils.disposeObject(_rightBottomView);
         _rightBottomView = null;
      }
   }
}
