package wantstrong.model
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import wantstrong.WantStrongManager;
   import wantstrong.data.WantStrongMenuData;
   
   public class WantStrongModel extends EventDispatcher implements Disposeable
   {
       
      
      private var _data:Dictionary;
      
      private var _activeId:int = 1;
      
      private var _titleArr1:Array;
      
      private var _titleArr2:Array;
      
      private var _titleArr3:Array;
      
      private var _titleArr4:Array;
      
      private var _titleArr5:Array;
      
      private var _descriptionArr1:Array;
      
      private var _descriptionArr2:Array;
      
      private var _descriptionArr3:Array;
      
      private var _descriptionArr4:Array;
      
      private var _descriptionArr5:Array;
      
      private var _starArr1:Array;
      
      private var _starArr2:Array;
      
      private var _starArr3:Array;
      
      private var _starArr4:Array;
      
      private var _starArr5:Array;
      
      private var _iconArr1:Array;
      
      private var _iconArr2:Array;
      
      private var _iconArr3:Array;
      
      private var _iconArr4:Array;
      
      private var _iconArr5:Array;
      
      private var _needLevelArr1:Array;
      
      private var _needLevelArr2:Array;
      
      private var _needLevelArr3:Array;
      
      private var _needLevelArr4:Array;
      
      private var _needLevelArr5:Array;
      
      private var _idArr1:Array;
      
      private var _idArr2:Array;
      
      private var _idArr3:Array;
      
      private var _idArr4:Array;
      
      private var _idArr5:Array;
      
      private var _bossTypeDic:Dictionary;
      
      public function WantStrongModel(param1:IEventDispatcher = null)
      {
         _titleArr1 = ["ddt.wantStrong.view.texp","ddt.wantStrong.view.totem","ddt.wantStrong.view.gemstone","ddt.wantStrong.view.card","ddt.wantStrong.view.pet","ddt.wantStrong.view.equip","ddt.wantStrong.view.jewelery","ddt.wantStrong.view.gem","ddt.wantStrong.view.bead","ddt.wantStrong.view.bury","ddt.wantStrong.view.gold","ddt.wantStrong.view.power","ddt.wantStrong.view.horse","ddt.wantStrong.view.magic","ddt.wantStrong.view.clsoet","ddt.wantStrong.view.enchant"];
         _titleArr2 = ["ddt.wantStrong.view.fam","ddt.wantStrong.view.task","ddt.wantStrong.view.fight"];
         _titleArr3 = ["ddt.wantStrong.view.daywright","ddt.wantStrong.view.treasure"];
         _titleArr4 = ["ddt.wantStrong.view.dungeon"];
         _titleArr5 = ["ddt.wantStrong.view.boss1","ddt.wantStrong.view.boss2","ddt.wantStrong.view.captain","ddt.wantStrong.view.battle","ddt.wantStrong.view.competition"];
         _descriptionArr1 = ["ddt.wantStrong.view.texpDescription","ddt.wantStrong.view.totemDescription","ddt.wantStrong.view.gemstoneDescription","ddt.wantStrong.view.cardDescription","ddt.wantStrong.view.petDescription","ddt.wantStrong.view.equipDescription","ddt.wantStrong.view.jeweleryDescription","ddt.wantStrong.view.gemDescription","ddt.wantStrong.view.beadDescription","ddt.wantStrong.view.buryDescription","ddt.wantStrong.view.goldDescription","ddt.wantStrong.view.powerDescription","ddt.wantStrong.view.horseDescription","ddt.wantStrong.view.magicDescription","ddt.wantStrong.view.clsoetDescription","ddt.wantStrong.view.enchantDescription"];
         _descriptionArr2 = ["ddt.wantStrong.view.famDescription","ddt.wantStrong.view.taskDescription","ddt.wantStrong.view.fightDescription"];
         _descriptionArr3 = ["ddt.wantStrong.view.daywrightDescription","ddt.wantStrong.view.treasureDescription"];
         _descriptionArr4 = ["ddt.wantStrong.view.dungeonDescription"];
         _descriptionArr5 = ["ddt.wantStrong.view.boss1Description","ddt.wantStrong.view.boss2Description","ddt.wantStrong.view.captainDescription","ddt.wantStrong.view.battleDescription","ddt.wantStrong.view.competitionDescription"];
         _starArr1 = [5,5,5,4,5,5,4,5,5,5,5,4,5,4,4,3];
         _starArr2 = [5,5,4];
         _starArr3 = [5,4];
         _starArr4 = [5];
         _starArr5 = [5,5,5,5,5];
         _iconArr1 = ["wantstrong.texp","wantstrong.totem","wantstrong.gemstone","wantstrong.card","wantstrong.pet","wantstrong.equip","wantstrong.jewelery","wantstrong.gem","wantstrong.bead","wantstrong.bury","wantstrong.gold","wantstrong.power","wantstrong.horse","wantstrong.magic","wantstrong.clsoet","wantstrong.enchant"];
         _iconArr2 = ["wantstrong.fam","wantstrong.task","wantstrong.fight"];
         _iconArr3 = ["wantstrong.daywright","wantstrong.treasure"];
         _iconArr4 = ["wantstrong.dungeon"];
         _iconArr5 = ["wantstrong.boss1","wantstrong.boss2","wantstrong.captain","wantstrong.battle","wantstrong.competition"];
         _needLevelArr1 = [13,22,30,15,19,7,7,7,16,25,12,30,12,45,10,40];
         _needLevelArr2 = [30,7,7];
         _needLevelArr3 = [7,10];
         _needLevelArr4 = [18];
         _needLevelArr5 = [0,0,0,0,0];
         _idArr1 = [101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116];
         _idArr2 = [201,202,203];
         _idArr3 = [301,302];
         _idArr4 = [401];
         _idArr5 = [501,502,503,504,505];
         super(param1);
         _data = new Dictionary();
         _bossTypeDic = new Dictionary();
         _bossTypeDic[501] = 6;
         _bossTypeDic[502] = 18;
         _bossTypeDic[503] = 19;
         _bossTypeDic[504] = 5;
         _bossTypeDic[505] = 4;
      }
      
      public function get bossTypeDic() : Dictionary
      {
         return _bossTypeDic;
      }
      
      public function initFindBackData() : void
      {
         var _loc3_:int = 0;
         var _loc16_:int = 0;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         var _loc13_:int = 0;
         var _loc12_:int = 0;
         var _loc14_:* = null;
         var _loc4_:int = 0;
         var _loc15_:* = ServerConfigManager.instance.findInfoByName("WorldBossFindBack");
         var _loc10_:Array = String(_loc15_.Value).split("|");
         _loc16_ = 0;
         while(_loc16_ < _loc10_.length)
         {
            _loc7_ = _loc10_[_loc16_].split(",");
            if(PlayerManager.Instance.Self.Grade >= _loc7_[0] && PlayerManager.Instance.Self.Grade <= _loc7_[1])
            {
               _loc3_ = _loc7_[2];
               break;
            }
            _loc16_++;
         }
         var _loc11_:* = ServerConfigManager.instance.findInfoByName("WorldBossFindBackMoney");
         _loc8_ = _loc11_.Value * _loc3_ / 100;
         var _loc5_:* = ServerConfigManager.instance.findInfoByName("FairBattleFindBackMoney");
         _loc9_ = String(_loc5_.Value).split(",")[1];
         _loc1_ = String(_loc5_.Value).split(",")[0];
         var _loc6_:* = ServerConfigManager.instance.findInfoByName("DailyLeagueFindBackMoney");
         _loc13_ = String(_loc6_.Value).split(",")[1];
         _loc12_ = String(_loc6_.Value).split(",")[0];
         var _loc2_:Vector.<WantStrongMenuData> = new Vector.<WantStrongMenuData>();
         _loc4_ = 0;
         while(_loc4_ < WantStrongManager.Instance.findBackDataExist.length)
         {
            if(WantStrongManager.Instance.findBackDataExist[_loc4_])
            {
               _loc14_ = new WantStrongMenuData();
               _loc14_.title = LanguageMgr.GetTranslation(_titleArr5[_loc4_]);
               _loc14_.starNum = _starArr5[_loc4_];
               _loc14_.description = LanguageMgr.GetTranslation(_descriptionArr5[_loc4_]);
               _loc14_.needLevel = _needLevelArr5[_loc4_];
               _loc14_.iconUrl = _iconArr5[_loc4_];
               _loc14_.id = _idArr5[_loc4_];
               _loc14_.type = 5;
               _loc14_.bossType = _bossTypeDic[_loc14_.id];
               _loc14_.freeBackBtnEnable = WantStrongManager.Instance.findBackDic[_loc14_.bossType] == null?true:!WantStrongManager.Instance.findBackDic[_loc14_.bossType][0];
               _loc14_.allBackBtnEnable = WantStrongManager.Instance.findBackDic[_loc14_.bossType] == null?true:!WantStrongManager.Instance.findBackDic[_loc14_.bossType][1];
               if(_loc4_ < _titleArr5.length - 2)
               {
                  _loc14_.awardType = 1;
                  _loc14_.awardNum = _loc3_;
                  _loc14_.moneyNum = _loc8_;
               }
               else if(_loc4_ == _titleArr5.length - 2)
               {
                  _loc14_.awardType = 2;
                  _loc14_.awardNum = _loc9_;
                  _loc14_.moneyNum = _loc1_;
               }
               else if(_loc4_ == _titleArr5.length - 1)
               {
                  _loc14_.awardType = 3;
                  _loc14_.awardNum = _loc13_;
                  _loc14_.moneyNum = _loc12_;
               }
               _loc2_.push(_loc14_);
            }
            _loc4_++;
         }
         _data[5] = _loc2_;
      }
      
      public function initData() : void
      {
         var _loc4_:* = undefined;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc11_:* = null;
         var _loc7_:* = null;
         var _loc10_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         _loc5_ = 1;
         while(_loc5_ <= 4)
         {
            _loc8_ = this["_titleArr" + _loc5_] as Array;
            _loc11_ = this["_descriptionArr" + _loc5_] as Array;
            _loc7_ = this["_starArr" + _loc5_] as Array;
            _loc10_ = this["_iconArr" + _loc5_] as Array;
            _loc1_ = this["_needLevelArr" + _loc5_] as Array;
            _loc3_ = this["_idArr" + _loc5_] as Array;
            _loc2_ = _loc8_.length;
            _loc4_ = new Vector.<WantStrongMenuData>();
            _loc9_ = 0;
            while(_loc9_ < _loc2_)
            {
               if(_loc1_[_loc9_] <= PlayerManager.Instance.Self.Grade)
               {
                  _loc6_ = new WantStrongMenuData();
                  _loc6_.title = LanguageMgr.GetTranslation(_loc8_[_loc9_]);
                  _loc6_.starNum = _loc7_[_loc9_];
                  _loc6_.description = LanguageMgr.GetTranslation(_loc11_[_loc9_]);
                  _loc6_.needLevel = _loc1_[_loc9_];
                  _loc6_.iconUrl = _loc10_[_loc9_];
                  _loc6_.id = _loc3_[_loc9_];
                  _loc6_.type = _loc5_;
                  _loc4_.push(_loc6_);
                  if(_loc4_.length > 0)
                  {
                     _data[_loc5_] = _loc4_;
                  }
               }
               _loc9_++;
            }
            _loc5_++;
         }
      }
      
      public function changeActiveId(param1:int) : void
      {
         _activeId = param1;
      }
      
      public function get data() : Dictionary
      {
         return _data;
      }
      
      public function get activeId() : int
      {
         return _activeId;
      }
      
      public function set activeId(param1:int) : void
      {
         _activeId = param1;
      }
      
      public function dispose() : void
      {
      }
   }
}
