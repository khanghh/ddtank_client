package gameCommon.view.prop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.display.BitmapLoaderProxy;
   import ddt.manager.PathManager;
   import ddt.view.tips.ToolPropInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import pet.data.PetSkill;
   
   public class PetSkillCell extends PropCell
   {
       
      
      private var _skill:PetSkill;
      
      private var _turnNum:int = 0;
      
      private var _skillPic:BitmapLoaderProxy;
      
      private var _awakenSkillMc:MovieClip;
      
      private var _lockBg:Bitmap;
      
      private var _normHeight:Number;
      
      private var _normWidth:Number;
      
      private var _skillPicWidth:Number = 33;
      
      private var _skillPicHeight:Number = 33;
      
      public function PetSkillCell(param1:String = null, param2:int = -1, param3:Boolean = false, param4:Number = 0, param5:Number = 0)
      {
         super(param1,param2,param3);
         this.setGrayFilter();
         _normWidth = param4;
         _normHeight = param5;
      }
      
      override public function get tipStyle() : String
      {
         return "ddt.view.tips.PetSkillCellTip";
      }
      
      override public function get tipData() : Object
      {
         return _skill;
      }
      
      public function creteSkillCell(param1:PetSkill, param2:Boolean = false) : void
      {
         ShowTipManager.Instance.removeTip(this);
         _skill = param1;
         if(_skill != null)
         {
            _skillPic = new BitmapLoaderProxy(PathManager.solveSkillPicUrl(_skill.Pic),new Rectangle(0,0,_skillPicWidth,_skillPicHeight));
            addChild(_skillPic);
            if(_skill.exclusiveID > 0)
            {
               _awakenSkillMc = ComponentFactory.Instance.creat("asset.game.petSkill.AwakenMC");
               addChild(_awakenSkillMc);
            }
            ShowTipManager.Instance.addTip(this);
            _turnNum = _skill.ColdDown;
            buttonMode = true;
         }
         else
         {
            _fore = _bitmapMgr.creatBitmapShape("asset.game.petSkillBarCellBg",null,false,true);
            addChild(_fore);
            buttonMode = false;
            _tipInfo = null;
         }
         if(param2)
         {
            drawLockBg();
         }
         shortcutKeyConfigUI();
         positionAdjust();
      }
      
      private function positionAdjust() : void
      {
         if(_skillPic)
         {
            if(_normWidth > 0)
            {
               _skillPic.x = (_normWidth - _skillPicWidth) / 2;
            }
            if(_normHeight > 0)
            {
               _skillPic.y = (_normHeight - _skillPicHeight) / 2;
            }
         }
         if(_shortcutKeyShape && _skillPic)
         {
            _shortcutKeyShape.x = _skillPic.x;
            _shortcutKeyShape.y = _skillPic.y;
         }
         if(_fore)
         {
            if(_normWidth > 0)
            {
               _fore.x = (_normWidth - _skillPicWidth) / 2;
            }
            if(_normHeight > 0)
            {
               _fore.y = (_normHeight - _skillPicHeight) / 2;
            }
         }
      }
      
      private function drawLockBg() : void
      {
         if(!_skill && !_lockBg)
         {
            _lockBg = ComponentFactory.Instance.creatBitmap("asset.game.petSkillLockBg");
            addChild(_lockBg);
         }
      }
      
      override protected function configUI() : void
      {
         _tipInfo = new ToolPropInfo();
         _tipInfo.showThew = true;
      }
      
      private function shortcutKeyConfigUI() : void
      {
         if(_shortcutKey != null && _shortcutKeyShape == null)
         {
            if(_skill && _skill.isActiveSkill || !_skill)
            {
               _shortcutKeyShape = ComponentFactory.Instance.creatBitmap("asset.game.prop.ShortcutKey" + _shortcutKey);
               Bitmap(_shortcutKeyShape).smoothing = true;
               _shortcutKeyShape.y = -2;
               addChild(_shortcutKeyShape);
               drawLayer();
            }
            else
            {
               _shortcutKey = null;
            }
         }
      }
      
      public function get skillInfo() : PetSkill
      {
         return _skill;
      }
      
      public function get isEnabled() : Boolean
      {
         if(_skill && _skill.isActiveSkill)
         {
            return true;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_lockBg)
         {
            ObjectUtils.disposeObject(_lockBg);
         }
         _lockBg = null;
         ObjectUtils.disposeObject(_skillPic);
         _skillPic = null;
         _skill = null;
         if(_awakenSkillMc)
         {
            ObjectUtils.disposeObject(_awakenSkillMc);
            _awakenSkillMc = null;
         }
      }
      
      public function get turnNum() : int
      {
         return _turnNum;
      }
      
      public function set turnNum(param1:int) : void
      {
         _turnNum = param1;
      }
   }
}
