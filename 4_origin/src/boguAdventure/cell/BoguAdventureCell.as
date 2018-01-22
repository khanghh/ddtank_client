package boguAdventure.cell
{
   import bagAndInfo.cell.BaseCell;
   import boguAdventure.model.BoguAdventureCellInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class BoguAdventureCell extends Sprite implements Disposeable
   {
      
      public static const PLAY_COMPLETE:String = "playcomplete";
       
      
      private var _cellBg:Bitmap;
      
      private var _info:BoguAdventureCellInfo;
      
      private var _goodsBg:BaseCell;
      
      private var _shine:MovieClip;
      
      private var _lightFilter:ColorMatrixFilter;
      
      private var _isMove:Boolean;
      
      public function BoguAdventureCell()
      {
         super();
         _cellBg = UICreatShortcut.creatAndAdd("boguAdventure.gameView.CellBg",this);
         _lightFilter = ComponentFactory.Instance.model.getSet("lightFilter");
         this.buttonMode = true;
         this.graphics.beginFill(0,0.1);
         this.graphics.drawRect(0,0,width,height);
         this.graphics.endFill();
         this.addEventListener("mouseMove",__onMove);
         this.addEventListener("mouseOut",__onOut);
      }
      
      public function set info(param1:BoguAdventureCellInfo) : void
      {
         _info = param1;
         _info.state == 2?open():close();
         ObjectUtils.disposeObject(_goodsBg);
         _goodsBg = null;
      }
      
      public function get info() : BoguAdventureCellInfo
      {
         return _info;
      }
      
      public function changeCellBg() : void
      {
         if(_goodsBg)
         {
            _goodsBg.removeEventListener("click",__onClick);
         }
         ObjectUtils.disposeObject(_goodsBg);
         _goodsBg = null;
         if(_info.result != -1 && _info.result != -2)
         {
            _goodsBg = new BaseCell(new Sprite(),ItemManager.Instance.getTemplateById(_info.result));
            _goodsBg.setContentSize(_cellBg.width,_cellBg.height);
            _goodsBg.addEventListener("click",__onClick);
            _goodsBg.addEventListener("mouseMove",__onMove);
            _goodsBg.addEventListener("mouseOut",__onOut);
            addChild(_goodsBg);
         }
      }
      
      private function __onMove(param1:MouseEvent) : void
      {
         lightFilter = true;
      }
      
      private function __onOut(param1:MouseEvent) : void
      {
         lightFilter = false;
      }
      
      public function playShineAction() : void
      {
         if(_shine)
         {
            return;
         }
         _shine = UICreatShortcut.creatAndAdd("boguAdventure.mapView.cellShine",this);
         _shine.addEventListener("enterFrame",__onPlayComplete);
         _shine.play();
      }
      
      private function set lightFilter(param1:Boolean) : void
      {
         if(_isMove == param1)
         {
            return;
         }
         _isMove = param1;
         this.filters = !!_isMove?[_lightFilter]:null;
      }
      
      private function __onPlayComplete(param1:Event) : void
      {
         if(_shine.currentFrame == _shine.totalFrames)
         {
            _shine.stop();
            _shine.removeEventListener("enterFrame",__onPlayComplete);
            ObjectUtils.disposeObject(_shine);
            _shine = null;
            dispatchEvent(new Event("playcomplete"));
         }
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         dispatchEvent(new MouseEvent("click"));
      }
      
      public function close() : void
      {
         _cellBg.visible = true;
      }
      
      public function open() : void
      {
         _cellBg.visible = false;
      }
      
      override public function get width() : Number
      {
         return 55;
      }
      
      override public function get height() : Number
      {
         return 51;
      }
      
      public function dispose() : void
      {
         this.graphics.clear();
         _lightFilter = null;
         this.removeEventListener("mouseMove",__onMove);
         this.removeEventListener("mouseOut",__onOut);
         if(_shine)
         {
            _shine.stop();
            _shine.removeEventListener("enterFrame",__onPlayComplete);
            ObjectUtils.disposeObject(_shine);
            _shine = null;
         }
         ObjectUtils.disposeObject(_cellBg);
         _cellBg = null;
         if(_goodsBg)
         {
            _goodsBg.removeEventListener("click",__onClick);
            _goodsBg.removeEventListener("mouseMove",__onMove);
            _goodsBg.removeEventListener("mouseOut",__onOut);
         }
         ObjectUtils.disposeObject(_goodsBg);
         _goodsBg = null;
      }
   }
}
