package wantstrong.model
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.data.ServerConfigInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
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
      
      public function WantStrongModel(target:IEventDispatcher = null)
      {
         _titleArr1 = ["ddt.wantStrong.view.texp","ddt.wantStrong.view.totem","ddt.wantStrong.view.gemstone","ddt.wantStrong.view.card","ddt.wantStrong.view.pet","ddt.wantStrong.view.equip","ddt.wantStrong.view.jewelery","ddt.wantStrong.view.gem","ddt.wantStrong.view.bead","ddt.wantStrong.view.bury","ddt.wantStrong.view.gold","ddt.wantStrong.view.power","ddt.wantStrong.view.horse","ddt.wantStrong.view.magic","ddt.wantStrong.view.clsoet","ddt.wantStrong.view.enchant"];
         _titleArr2 = ["ddt.wantStrong.view.fam","ddt.wantStrong.view.task","ddt.wantStrong.view.fight"];
         _titleArr3 = ["ddt.wantStrong.view.daywright","ddt.wantStrong.view.treasure"];
         _titleArr4 = ["ddt.wantStrong.view.dungeon"];
         _titleArr5 = ["ddt.wantStrong.view.boss1","ddt.wantStrong.view.boss2","ddt.wantStrong.view.captain","ddt.wantStrong.view.battle","ddt.wantStrong.view.competition","ddt.wantStrong.view.findTitle1","ddt.wantStrong.view.findTitle2","ddt.wantStrong.view.findTitle3"];
         _descriptionArr1 = ["ddt.wantStrong.view.texpDescription","ddt.wantStrong.view.totemDescription","ddt.wantStrong.view.gemstoneDescription","ddt.wantStrong.view.cardDescription","ddt.wantStrong.view.petDescription","ddt.wantStrong.view.equipDescription","ddt.wantStrong.view.jeweleryDescription","ddt.wantStrong.view.gemDescription","ddt.wantStrong.view.beadDescription","ddt.wantStrong.view.buryDescription","ddt.wantStrong.view.goldDescription","ddt.wantStrong.view.powerDescription","ddt.wantStrong.view.horseDescription","ddt.wantStrong.view.magicDescription","ddt.wantStrong.view.clsoetDescription","ddt.wantStrong.view.enchantDescription"];
         _descriptionArr2 = ["ddt.wantStrong.view.famDescription","ddt.wantStrong.view.taskDescription","ddt.wantStrong.view.fightDescription"];
         _descriptionArr3 = ["ddt.wantStrong.view.daywrightDescription","ddt.wantStrong.view.treasureDescription"];
         _descriptionArr4 = ["ddt.wantStrong.view.dungeonDescription"];
         _descriptionArr5 = ["ddt.wantStrong.view.boss1Description","ddt.wantStrong.view.boss2Description","ddt.wantStrong.view.captainDescription","ddt.wantStrong.view.battleDescription","ddt.wantStrong.view.competitionDescription","ddt.wantStrong.view.findDecs1","ddt.wantStrong.view.findDecs2","ddt.wantStrong.view.findDecs3"];
         _starArr1 = [5,5,5,4,5,5,4,5,5,5,5,4,5,4,4,3];
         _starArr2 = [5,5,4];
         _starArr3 = [5,4];
         _starArr4 = [5];
         _starArr5 = [5,5,5,5,5,5,5,5];
         _iconArr1 = ["wantstrong.texp","wantstrong.totem","wantstrong.gemstone","wantstrong.card","wantstrong.pet","wantstrong.equip","wantstrong.jewelery","wantstrong.gem","wantstrong.bead","wantstrong.bury","wantstrong.gold","wantstrong.power","wantstrong.horse","wantstrong.magic","wantstrong.clsoet","wantstrong.enchant"];
         _iconArr2 = ["wantstrong.fam","wantstrong.task","wantstrong.fight"];
         _iconArr3 = ["wantstrong.daywright","wantstrong.treasure"];
         _iconArr4 = ["wantstrong.dungeon"];
         _iconArr5 = ["wantstrong.boss1","wantstrong.boss2","wantstrong.captain","wantstrong.battle","wantstrong.competition","wantstrong.findIcon1","wantstrong.findIcon2","wantstrong.findIcon3"];
         _needLevelArr1 = [13,22,30,15,19,7,7,7,16,25,12,30,12,45,10,40];
         _needLevelArr2 = [30,7,7];
         _needLevelArr3 = [7,10];
         _needLevelArr4 = [18];
         _needLevelArr5 = [0,0,0,0,0,0,0,0];
         _idArr1 = [101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116];
         _idArr2 = [201,202,203];
         _idArr3 = [301,302];
         _idArr4 = [401];
         _idArr5 = [501,502,503,504,505,506,507,508];
         super(target);
         _data = new Dictionary();
         _bossTypeDic = new Dictionary();
         _bossTypeDic[501] = 6;
         _bossTypeDic[502] = 18;
         _bossTypeDic[503] = 19;
         _bossTypeDic[504] = 5;
         _bossTypeDic[505] = 4;
         _bossTypeDic[506] = 25;
         _bossTypeDic[507] = 30;
         _bossTypeDic[508] = 31;
      }
      
      public function get bossTypeDic() : Dictionary
      {
         return _bossTypeDic;
      }
      
      public function initFindBackData() : void
      {
         var honorNum:int = 0;
         var v_i:int = 0;
         var levelHonorArr:* = null;
         var worldBossMoneyNum:int = 0;
         var configInfo:* = null;
         var wantStrongData:* = null;
         var i:int = 0;
         var worldBossFindBackInfo:* = ServerConfigManager.instance.findInfoByName("WorldBossFindBack");
         var valueArr:Array = String(worldBossFindBackInfo.Value).split("|");
         for(v_i = 0; v_i < valueArr.length; )
         {
            levelHonorArr = valueArr[v_i].split(",");
            if(PlayerManager.Instance.Self.Grade >= levelHonorArr[0] && PlayerManager.Instance.Self.Grade <= levelHonorArr[1])
            {
               honorNum = levelHonorArr[2];
               break;
            }
            v_i++;
         }
         var worldBossFindBackMoneyInfo:* = ServerConfigManager.instance.findInfoByName("WorldBossFindBackMoney");
         worldBossMoneyNum = worldBossFindBackMoneyInfo.Value * honorNum / 100;
         var findAwardConfig:DictionaryData = new DictionaryData(true);
         findAwardConfig.add(3,"FairBattleFindBackMoney");
         findAwardConfig.add(4,"DailyLeagueFindBackMoney");
         findAwardConfig.add(5,"CryptBossFindBackMoney");
         findAwardConfig.add(6,"DailyTaskFindBackMoney");
         findAwardConfig.add(7,"ProvingDungeonFindBackMoney");
         var data:Vector.<WantStrongMenuData> = new Vector.<WantStrongMenuData>();
         for(i = 0; i < WantStrongManager.Instance.findBackDataExist.length; )
         {
            if(WantStrongManager.Instance.findBackDataExist[i])
            {
               wantStrongData = new WantStrongMenuData();
               wantStrongData.title = LanguageMgr.GetTranslation(_titleArr5[i]);
               wantStrongData.starNum = _starArr5[i];
               wantStrongData.description = LanguageMgr.GetTranslation(_descriptionArr5[i]);
               wantStrongData.needLevel = _needLevelArr5[i];
               wantStrongData.iconUrl = _iconArr5[i];
               wantStrongData.id = _idArr5[i];
               wantStrongData.type = 5;
               wantStrongData.bossType = _bossTypeDic[wantStrongData.id];
               wantStrongData.freeBackBtnEnable = WantStrongManager.Instance.findBackDic[wantStrongData.bossType] == null?true:!WantStrongManager.Instance.findBackDic[wantStrongData.bossType][0];
               wantStrongData.allBackBtnEnable = WantStrongManager.Instance.findBackDic[wantStrongData.bossType] == null?true:!WantStrongManager.Instance.findBackDic[wantStrongData.bossType][1];
               if(i < 3)
               {
                  wantStrongData.awardType = 1;
                  wantStrongData.awardNum = honorNum;
                  wantStrongData.moneyNum = worldBossMoneyNum;
               }
               else
               {
                  configInfo = ServerConfigManager.instance.findInfoByName(findAwardConfig[i]);
                  wantStrongData.awardType = i;
                  wantStrongData.awardNum = configInfo.Value.split(",")[1];
                  wantStrongData.moneyNum = configInfo.Value.split(",")[0];
               }
               data.push(wantStrongData);
            }
            i++;
         }
         _data[5] = data;
         findAwardConfig.clear();
      }
      
      public function initData() : void
      {
         var data:* = undefined;
         var wantStrongData:* = null;
         var vFlag:int = 0;
         var titleArr:* = null;
         var descriptionArr:* = null;
         var starArr:* = null;
         var iconArr:* = null;
         var needLevelArr:* = null;
         var idArr:* = null;
         var i:int = 0;
         var count:int = 0;
         for(vFlag = 1; vFlag <= 4; )
         {
            titleArr = this["_titleArr" + vFlag] as Array;
            descriptionArr = this["_descriptionArr" + vFlag] as Array;
            starArr = this["_starArr" + vFlag] as Array;
            iconArr = this["_iconArr" + vFlag] as Array;
            needLevelArr = this["_needLevelArr" + vFlag] as Array;
            idArr = this["_idArr" + vFlag] as Array;
            count = titleArr.length;
            data = new Vector.<WantStrongMenuData>();
            for(i = 0; i < count; )
            {
               if(needLevelArr[i] <= PlayerManager.Instance.Self.Grade)
               {
                  wantStrongData = new WantStrongMenuData();
                  wantStrongData.title = LanguageMgr.GetTranslation(titleArr[i]);
                  wantStrongData.starNum = starArr[i];
                  wantStrongData.description = LanguageMgr.GetTranslation(descriptionArr[i]);
                  wantStrongData.needLevel = needLevelArr[i];
                  wantStrongData.iconUrl = iconArr[i];
                  wantStrongData.id = idArr[i];
                  wantStrongData.type = vFlag;
                  data.push(wantStrongData);
                  if(data.length > 0)
                  {
                     _data[vFlag] = data;
                  }
               }
               i++;
            }
            vFlag++;
         }
      }
      
      public function changeActiveId(num:int) : void
      {
         _activeId = num;
      }
      
      public function get data() : Dictionary
      {
         return _data;
      }
      
      public function get activeId() : int
      {
         return _activeId;
      }
      
      public function set activeId(value:int) : void
      {
         _activeId = value;
      }
      
      public function dispose() : void
      {
      }
   }
}
