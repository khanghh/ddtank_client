package ddt.view.horse
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import horse.HorseManager;
   import horse.data.HorseSkillGetVo;
   import horse.data.HorseSkillVo;
   
   public class HorseSkillCell extends Sprite implements ITipedDisplay, Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _skillId:int;
      
      private var _skillGetInfo:HorseSkillGetVo;
      
      private var _skillInfo:HorseSkillVo;
      
      private var _skillIcon:Bitmap;
      
      public function HorseSkillCell(param1:int, param2:Boolean = true, param3:Boolean = false)
      {
         super();
         _skillId = param1;
         _skillGetInfo = HorseManager.instance.getHorseSkillGetInfoById(_skillId);
         _skillInfo = HorseManager.instance.getHorseSkillInfoById(_skillId);
         _skillIcon = ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop" + _skillInfo.Pic + "Asset");
         if(param2)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.horse.skillFrame.cell.bg");
            addChild(_bg);
            param3 = true;
         }
         if(param3)
         {
            _skillIcon.smoothing = true;
            _skillIcon.width = 38;
            _skillIcon.height = 38;
            _skillIcon.x = 3;
            _skillIcon.y = 3;
         }
         addChild(_skillIcon);
         ShowTipManager.Instance.addTip(this);
      }
      
      public function get tipData() : Object
      {
         return _skillInfo;
      }
      
      public function set tipData(param1:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return "5,2,7,1,6,4";
      }
      
      public function set tipDirctions(param1:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 5;
      }
      
      public function set tipGapH(param1:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 5;
      }
      
      public function set tipGapV(param1:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         return "horse.view.HorseSkillCellTip";
      }
      
      public function set tipStyle(param1:String) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _skillGetInfo = null;
         _skillInfo = null;
         _skillIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
