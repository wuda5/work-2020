export default {
  data() {
    return {
      genderOptions: [
        {
          value: 'M',
          label: '男'
        },
        {
          value: 'W',
          label: '女'
        },
        {
          value: 'N',
          label: '保密'
        }
      ],
      serviceHallOptions: [
        {
          value: '1',
          label: '温江营业厅'
        },
        {
          value: '2',
          label: '天府燃气营业厅'
        },
        {
          value: '3',
          label: '秦川直营燃气厅'
        }
      ],
      jobOptions: [
        {
          value: '1',
          label: '收银员'
        },
        {
          value: '2',
          label: '安装人员'
        },
        {
          value: '3',
          label: '柜台'
        },
        {
          value: '4',
          label: '财务'
        },
        {
          value: '5',
          label: '清洁工'
        }
      ],
      roleOptions: [
        {
          value: '1',
          label: '管理员'
        },
        {
          value: '2',
          label: '运维'
        },
        {
          value: '3',
          label: '柜台'
        },
        {
          value: '4',
          label: '财务'
        }
      ]
    }
  }
}
