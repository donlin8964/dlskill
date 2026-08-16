# dlskill 架构说明

## 定位

东临内容创作方法论的 AI Skill 实现。专注自媒体内容创作垂直领域：写稿、磨稿、诊断、选题、平台适配。

## 当前架构（v0.x —— 单 skill 阶段）

所有能力封装在一个 `dlskill` skill 中，通过 `references/` 下的模块化文件组织：

```
dlskill/
├── SKILL.md              主入口，9步核心流程
├── references/
│   ├── frameworks.md     五大框架 + 混搭 + 故事工具箱
│   ├── checklist.md      三层质检
│   ├── platform.md       平台适配
│   ├── language.md       语言手册
│   └── iteration.md      迭代拆解模板
├── docs/                 架构文档
├── scripts/              工具脚本
├── VERSION               语义化版本号
└── README.md
```

## 目标架构（v1.0 —— 多 skill 拆分）

拆分为多个独立 skill，统一 `dls-` 前缀，建主入口路由：

```
dlskill/
├── skills/
│   ├── dls/              主入口，路由 + 版本说明
│   ├── dls-topic/        选题评估
│   ├── dls-core/         真意核 + 情绪扣
│   ├── dls-framework/    框架选择 + 混搭
│   ├── dls-title/        标题生成
│   ├── dls-write/        搭结构填内容
│   ├── dls-polish/       语言翻译 + 磨稿
│   ├── dls-check/        三层质检
│   ├── dls-platform/     平台适配
│   └── dls-diagnose/     内容诊断
├── 知识库/                方法论知识库（与 skill 分离）
├── docs/
├── scripts/
├── tools/
├── .github/workflows/    自动发布
├── VERSION
└── README.md
```

## 拆分原则

1. **单一职责**：每个 skill 只做一件事，输入输出清晰
2. **可独立使用**：每个 skill 都能单独触发，不依赖主入口
3. **可联动**：主入口 `dls` 负责流水线编排，skill 间可互相调用
4. **知识与逻辑分离**：方法论知识库独立存放，skill 引用知识

## 版本规范

- 语义化版本：`MAJOR.MINOR.PATCH`
  - MAJOR：架构变更（如单skill→多skill）
  - MINOR：新增能力/框架/模块
  - PATCH：修复/优化/内容补充
- 版本号同时存在于 `VERSION` 文件和 `SKILL.md` 头部
- README 更新日志按版本倒序排列，每个版本写清楚「新增了什么、改了什么、为什么」

## 命名规范

- skill 目录：`dls-xxx`（全小写，连字符分隔）
- 触发命令：`/dls-xxx` 或自然语言描述
- 参考文件：`references/xxx.md`

## 迭代节奏

- v0.x：单skill阶段，快速迭代方法论，把内容做厚
- v1.0：架构拆分，多skill化
- v1.x：工程化完善（自动发布、安装脚本、文档站）
- v2.x：skill间联动 + 跨会话状态管理
