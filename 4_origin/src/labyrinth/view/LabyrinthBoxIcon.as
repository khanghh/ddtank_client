package labyrinth.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import labyrinth.LabyrinthManager;
   
   public class LabyrinthBoxIcon extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      private var _icon:Bitmap;
      
      private var _levelText:GradientText;
      
      private var _index:int;
      
      private var _level:int;
      
      private var _tipStyle:String;
      
      private var _tipDirctions:String;
      
      private var _tipData:Object;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _myColorMatrix_filter:ColorMatrixFilter;
      
      public function LabyrinthBoxIcon(param1:int)
      {
         _myColorMatrix_filter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
         _index = param1;
         super();
         init();
      }
      
      private function init() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap("ddt.labyrinth.Box");
         addChild(_icon);
         _levelText = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.BoxText");
         addChild(_levelText);
         tipStyle = "labyrinth.view.LabyrinthBoxIconTips";
         tipDirctions = "7,2,5";
         update();
         LabyrinthManager.Instance.addEventListener("updateInfo",__updateInfo);
      }
      
      protected function __updateInfo(param1:Event) : void
      {
         update();
      }
      
      private function update() : void
      {
         var _loc2_:String = "";
         var _loc1_:int = LabyrinthManager.Instance.model.myProgress;
         if(_loc1_ <= 20)
         {
            _level = _index * 2;
         }
         else if(_loc1_ <= 40)
         {
            _level = 20 + _index * 2;
         }
         else
         {
            _level = 40 + _index * 2;
         }
         if(_loc1_ + 2 < _level)
         {
            _loc2_ = "?";
            this.filters = [_myColorMatrix_filter];
            ShowTipManager.Instance.removeTip(this);
         }
         else if(_loc1_ < _level)
         {
            _loc2_ = _level.toString() + LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIcon.floor");
            this.filters = [_myColorMatrix_filter];
            ShowTipManager.Instance.addTip(this);
            if(_level == 32)
            {
               tipData = {"label":LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIconTips.labelII")};
               ShowTipManager.Instance.addTip(this);
            }
         }
         else
         {
            _loc2_ = _level.toString() + LanguageMgr.GetTranslation("ddt.labyrinth.LabyrinthBoxIcon.floor");
            this.filters = null;
            ShowTipManager.Instance.addTip(this);
         }
         _levelText.text = _loc2_;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirctions = param1;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         LabyrinthManager.Instance.removeEventListener("updateInfo",__updateInfo);
         ShowTipManager.Instance.removeTip(this);
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_levelText);
         _levelText = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
