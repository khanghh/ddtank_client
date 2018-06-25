package battleSkill.view
{
   import battleSkill.info.BattleSkillSkillInfo;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   
   public class BattleSkillCell extends Sprite implements ITipedDisplay, Disposeable
   {
       
      
      protected var _bg:Bitmap;
      
      protected var _lockIcon:Bitmap;
      
      protected var _isLock:Boolean;
      
      private var _skillIcon:Bitmap;
      
      private var _data:BattleSkillSkillInfo;
      
      private var _skillInfo:HorseSkillVo;
      
      private var _loaderPic:DisplayLoader;
      
      protected var _skillSprite:Sprite;
      
      private var _showBg:Boolean = true;
      
      private var _index:int;
      
      private var _isInit:Boolean = false;
      
      private var _id:int;
      
      public function BattleSkillCell(index:int = 0, showBg:Boolean = true, isLock:Boolean = false)
      {
         super();
         _index = index;
         _showBg = showBg;
         _isLock = isLock;
         initView();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.battleSkill.skillCell");
         addChild(_bg);
         _bg.visible = _showBg;
         _lockIcon = ComponentFactory.Instance.creatBitmap("asset.ddtcoreii.battleskillView.skillLockIcon");
         _lockIcon.visible = false;
         addChild(_lockIcon);
         _skillSprite = new Sprite();
         var _loc1_:int = 4;
         _skillSprite.y = _loc1_;
         _skillSprite.x = _loc1_;
         addChild(_skillSprite);
         if(_data != null)
         {
            _isInit = true;
            ShowTipManager.Instance.addTip(this);
         }
      }
      
      public function set info(data:BattleSkillSkillInfo) : void
      {
         if(data == null)
         {
            if(_isLock)
            {
               _lockIcon.visible = true;
            }
            return;
         }
         if(_data && _data.SkillID == data.SkillID)
         {
            return;
         }
         if(!_isInit)
         {
            ShowTipManager.Instance.addTip(this);
         }
         _data = data;
         initIcon();
      }
      
      public function get info() : BattleSkillSkillInfo
      {
         return _data;
      }
      
      public function get place() : int
      {
         return _index;
      }
      
      private function initIcon() : void
      {
         if(_skillSprite)
         {
            _skillSprite.removeChildren();
         }
         _skillInfo = HorseManager.instance.getHorseSkillInfoById(_data.SkillID);
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = ComponentFactory.Instance.creatBitmap("game.crazyTank.view.Prop" + _skillInfo.Pic + "Asset");
         var _loc1_:int = 38;
         _skillIcon.height = _loc1_;
         _skillIcon.width = _loc1_;
         _skillSprite.addChild(_skillIcon);
      }
      
      public function get tipData() : Object
      {
         return !!_skillInfo?_skillInfo:new HorseSkillVo();
      }
      
      public function set tipData(value:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return "5,2,7,1,6,4";
      }
      
      public function set tipDirctions(value:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 5;
      }
      
      public function set tipGapH(value:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 5;
      }
      
      public function set tipGapV(value:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         return "horse.view.HorseSkillCellTip";
      }
      
      public function set tipStyle(value:String) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set id(value:int) : void
      {
         _id = id;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_skillSprite)
         {
            ObjectUtils.disposeObject(_skillSprite);
            _skillSprite = null;
         }
         if(_skillIcon)
         {
            _skillIcon.bitmapData.dispose();
            _skillIcon.bitmapData = null;
            _skillIcon = null;
         }
         _data = null;
         _skillInfo = null;
         ShowTipManager.Instance.removeTip(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
