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
      
      public function ChooseFrame()
      {
         super();
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.tryonSystem.title"),"","",true,false);
         _loc1_.submitLabel = LanguageMgr.GetTranslation("ok");
         _loc1_.moveEnable = false;
         info = _loc1_;
      }
      
      public function set controller(param1:TryonSystemController) : void
      {
         _control = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChooseFrame.tryon.chooseItemBgAsset.bg");
         addToContent(_bg);
         _list = new SimpleTileList(2);
         _list.hSpace = 6;
         _list.vSpace = -5;
         PositionUtils.setPos(_list,"ChooseFrame.SimpleTileList.pos");
         _panel = ComponentFactory.Instance.creatComponentByStylename("core.quest.ChooseFrame.scrollPanel");
         _panel.setView(_list);
         addToContent(_panel);
         _cells = [];
         var _loc1_:AnimationControl = new AnimationControl();
         _loc1_.addEventListener("complete",_cellLightComplete);
         var _loc7_:int = 0;
         var _loc6_:* = _control.getModelByView(this).items;
         for each(var _loc4_ in _control.getModelByView(this).items)
         {
            _loc3_ = new QuestRewardCell();
            _loc3_.opitional = true;
            _loc3_.taskType = 1;
            _loc3_.info = _loc4_;
            _loc3_.addEventListener("click",__onclick);
            _loc3_.buttonMode = true;
            _cells.push(_loc3_);
            _list.addChild(_loc3_);
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("asset.core.itemShinelight");
            _loc5_.movie.play();
            _loc3_.addChildAt(_loc5_,1);
            _loc2_ = new GlowFilterAnimation();
            _loc2_.start(_loc5_,false,16763955,0,0);
            _loc2_.addMovie(0,0,19,0);
            _loc1_.addMovies(_loc2_);
         }
         _loc1_.startMovie();
      }
      
      private function _cellLightComplete(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         param1.currentTarget.removeEventListener("complete",_cellLightComplete);
         if(_cells)
         {
            _loc2_ = _cells.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _cells[_loc3_].removeChildAt(1);
               _loc3_++;
            }
         }
      }
      
      private function __onclick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var _loc2_ in _cells)
         {
            _loc2_.selected = false;
         }
         _control.getModelByView(this).selectedItem = QuestRewardCell(param1.currentTarget).info;
         QuestRewardCell(param1.currentTarget).selected = true;
      }
      
      override public function dispose() : void
      {
         _control = null;
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("click",__onclick);
            _loc1_.removeChildAt(1);
            _loc1_.dispose();
         }
         _cells = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         super.dispose();
      }
   }
}
