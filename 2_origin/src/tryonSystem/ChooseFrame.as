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
         var alertInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.tryonSystem.title"),"","",true,false);
         alertInfo.submitLabel = LanguageMgr.GetTranslation("ok");
         alertInfo.moveEnable = false;
         info = alertInfo;
      }
      
      public function set controller($control:TryonSystemController) : void
      {
         _control = $control;
         initView();
      }
      
      private function initView() : void
      {
         var cell:* = null;
         var _itemShine:* = null;
         var animation:* = null;
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
         var animationControl:AnimationControl = new AnimationControl();
         animationControl.addEventListener("complete",_cellLightComplete);
         var _loc7_:int = 0;
         var _loc6_:* = _control.getModelByView(this).items;
         for each(var item in _control.getModelByView(this).items)
         {
            cell = new QuestRewardCell();
            cell.opitional = true;
            cell.taskType = 1;
            cell.info = item;
            cell.addEventListener("click",__onclick);
            cell.buttonMode = true;
            _cells.push(cell);
            _list.addChild(cell);
            _itemShine = ComponentFactory.Instance.creatComponentByStylename("asset.core.itemShinelight");
            _itemShine.movie.play();
            cell.addChildAt(_itemShine,1);
            animation = new GlowFilterAnimation();
            animation.start(_itemShine,false,16763955,0,0);
            animation.addMovie(0,0,19,0);
            animationControl.addMovies(animation);
         }
         animationControl.startMovie();
      }
      
      private function _cellLightComplete(e:Event) : void
      {
         var len:int = 0;
         var i:int = 0;
         e.currentTarget.removeEventListener("complete",_cellLightComplete);
         if(_cells)
         {
            len = _cells.length;
            for(i = 0; i < len; )
            {
               _cells[i].removeChildAt(1);
               i++;
            }
         }
      }
      
      private function __onclick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var cell in _cells)
         {
            cell.selected = false;
         }
         _control.getModelByView(this).selectedItem = QuestRewardCell(event.currentTarget).info;
         QuestRewardCell(event.currentTarget).selected = true;
      }
      
      override public function dispose() : void
      {
         _control = null;
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.removeEventListener("click",__onclick);
            cell.removeChildAt(1);
            cell.dispose();
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
